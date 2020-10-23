import 'dart:convert';

class LoginModel {
  String address;
  String myCode;
  String userName;
  int uStatus;
  String token;
  String uid;
  String userMobile;
  String nickName;
  String userIcon;

  LoginModel(
      {this.address,
      this.myCode,
      this.userName,
      this.uStatus,
      this.token,
      this.uid,
      this.userMobile,
      this.nickName,
      this.userIcon});

  factory LoginModel.fromJson(Map<String, dynamic> json) => new LoginModel(
        address: json["result.address"],
        myCode: json["result.my_code"],
        userName: json["result.userName"],
        uStatus: json["result.uStatus"],
        token: json["result.token"],
        uid: json["result.uid"],
        userMobile: json["result.userMobile"],
        nickName: json["result.nickname"],
        userIcon: json["result.userIcon"],
      );
}
