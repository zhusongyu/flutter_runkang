import 'package:fluro/fluro.dart';
import 'package:flutter_runkang/coordinator/application.dart';
import 'package:flutter_runkang/coordinator/router_handler.dart';

class Routes {
  static const String ShopDetailWeb = 'ShopDetailWebView';

  static void configRouters() {
    final router = Router();
    Application.router = router;
    router.define(ShopDetailWeb, handler: shopDetailHandler);
  }
}
