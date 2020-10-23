import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_runkang/models.dart/login_model.dart';
import 'package:flutter_runkang/requests/httpmanager.dart';
import 'package:flutter_runkang/requests/login_request.dart';
import 'package:flutter_runkang/requests/result_data.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      builder: BotToastInit(),
      title: '登录',
      // theme: ThemeData(primaryColor: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
      // color: Colors.white,
      home: InputArea(),
    );
  }
}

class InputArea extends StatefulWidget {
  InputArea({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputAreaState();
  }
}

class _InputAreaState extends State<InputArea> {
  final _nameTextEditController = TextEditingController();
  final _pwdTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Material(
            child: TextField(
              controller: _nameTextEditController,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            child: TextField(
              controller: _pwdTextEditController,
            ),
          ),
          FlatButton(
            child: Text('登录'),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => ToastNoContext(),
              // ));
              // Fluttertoast.showToast(msg: "cdcdcd");

              login(_nameTextEditController.text, _pwdTextEditController.text);
            },
          )
        ],
      ),
    );
  }

  login(String name, String pwd) async {
    // Dio dio = Dio();
    // Response res;
    // res = await dio.post(
    //     "http://39.104.53.1:8080/jeesite/usercenter/user/login?mobile=$name&psw=$pwd");
    // LoginModel model = await LoginRequest.login(name, pwd);
    DataResult result = await LoginRequest.setup(name, pwd);
    if (result.result) {
    } else {
      BotToast.showText(text: result.data);
    }
  }
}
