import 'package:dio/dio.dart';
import 'package:flutter_runkang/models.dart/login_model.dart';
import 'package:flutter_runkang/requests/httpmanager.dart';
import 'package:flutter_runkang/requests/result_data.dart';

class LoginRequest {
  static setup(String name, String pwd) async {
    ResultData resultData = await HttpManager.post(
        "http://39.104.53.1:8080/jeesite/usercenter/user/login",
        {"mobile": name, "psw": pwd});
    if (resultData != null && resultData.result) {
      if (resultData.data["success"]) {
        LoginModel model = LoginModel.fromJson(resultData.data);
        return DataResult(model, true);
      }
      return DataResult(resultData.data["message"], false);
    } else {
      return DataResult(null, false);
    }
  }
}
