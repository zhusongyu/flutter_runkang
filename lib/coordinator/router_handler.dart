import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_runkang/pages/shop_detail.dart';

var shopDetailHandler = Handler(
  handlerFunc: (context, parameters) {
    return new ShopDetailWebView();
  },
);
