import 'package:flutter/material.dart';

class ShareList with ChangeNotifier {
  ShareList(
      {this.items});
  int num = 0;
  List items = [
    ShareItem(number: '1', buy: true, time: '20200101'),
    ShareItem(number: '2', buy: false, time: '20200202'),
    ShareItem(number: '3', buy: true, time: '20200303')
  ];
}

class ShareItem with ChangeNotifier {
  ShareItem({this.number = '', this.buy = false, this.time = ''});
  String number = '1';
  bool buy = false;
  String time = '2';
}
