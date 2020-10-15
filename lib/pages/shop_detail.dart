import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopDetailWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text('商品详情'),), body: WebView(
      initialUrl: 'https://flutter.cn',
    ),) ;
  }
}
