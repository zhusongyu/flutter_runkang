import 'dart:collection';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_runkang/config/config.dart';
import 'package:flutter_runkang/config/oauth_token_store.dart';
import 'package:flutter_runkang/requests/code.dart';
import 'package:flutter_runkang/requests/interceptors/error_interceptor.dart';
import 'package:flutter_runkang/requests/interceptors/response_interceptor.dart';
import 'package:flutter_runkang/requests/result_data.dart';

class HttpManager {
  static String _baseUrl = "";
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  HttpManager() {
    // _dio.interceptors.add(new LogsInterceptors());

    // _dio.interceptors.add(new ErrorInterceptors(_dio));

    // _dio.interceptors.add(new ResponseInterceptors());
  }

  // ///发起网络请求
  // ///[ url] 请求url
  // ///[ params] 请求参数
  // ///[ header] 外加头
  // ///[ option] 配置
  // netFetch(url, params, Options option, {noTip = false}) async {
  //   // Map<String, dynamic> headers = new HashMap();
  //   // if (headers != null) {
  //   //   headers.addAll(headers);
  //   // }

  //   if (option != null) {
  //     // option.headers = headers;
  //   } else {
  //     option = new Options(method: "get");
  //     // option.headers = headers;
  //   }

  //   resultError(DioError e) {
  //     Response errorResponse;
  //     if (e.response != null) {
  //       errorResponse = e.response;
  //     } else {
  //       errorResponse = new Response(statusCode: 666);
  //     }
  //     if (e.type == DioErrorType.CONNECT_TIMEOUT ||
  //         e.type == DioErrorType.RECEIVE_TIMEOUT) {
  //       errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  //     }
  //     return new ResultData(
  //         Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
  //         false,
  //         errorResponse.statusCode);
  //   }

  //   Response response;
  //   try {
  //     response = await _dio.request(url, data: params, options: option);
  //   } on DioError catch (e) {
  //     print(e);
  //     return resultError(e);
  //   }
  //   if (response.data is DioError) {
  //     return resultError(response.data);
  //   }
  //   return response.data;
  // }

  static setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  static get(url, param) async {
    return await request(
        _baseUrl + url, param, null, new Options(method: "GET"));
  }

  static post(url, param) async {
    return await request(_baseUrl + url, param,
        null, new Options(method: 'POST'));
  }

  static delete(url, param) async {
    return await request(
        _baseUrl + url, param, null, new Options(method: 'DELETE'));
  }

  // static put(url,param) async{
  //   return await request(_baseUrl+url, param, null, new Options(method: "PUT", contentType: ContentType.text));
  // }
  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static request(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    headers["Authorization"] = optionParams["authorizationCode"];
    // 设置 baseUrl

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.sendTimeout = 15000;
    option.receiveTimeout = 15000;
    option.contentType = CONTENT_TYPE_FORM;
    Dio dio = new Dio();
    // 添加拦截器
    if (Config.DEBUG) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("\n");
      }));
    }

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    try {
      if (option.contentType != null &&
          option.contentType == "text") {
        return new ResultData(response.data, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 && responseJson["token"] != null) {
          optionParams["authorizationCode"] = 'token ' + responseJson["token"];
          await OAuthTokenStore.saveToken(optionParams["authorizationCode"]);
        }
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return new ResultData(
        Code.errorHandleFunction(response.statusCode, "", noTip),
        false,
        response.statusCode);
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    OAuthTokenStore.saveToken("");
  }

  ///获取授权token
  static getAuthorization() async {
    String token = await OAuthTokenStore.fetchToken();
    if (token == null) {
      // String basic = await SpUtils.get(Config.USER_BASIC_CODE);
      // if (basic == null) {
      //   //提示输入账号密码
      // } else {
      //   //通过 basic 去获取token，获取到设置，返回token
      //   return "Basic $basic";
      // }
    } else {
      optionParams["authorizationCode"] = token;
      return token;
    }
  }
}
