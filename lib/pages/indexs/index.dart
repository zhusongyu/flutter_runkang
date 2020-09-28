import 'package:flutter/material.dart';
import 'package:flutter_runkang/pages/home_page.dart';
import 'package:flutter_runkang/pages/shop_page.dart';
import 'package:flutter_runkang/shared/image_factory.dart';
import 'navigation_icon_view.dart';


class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  int _currentIndex = 0;
  
  List<NavigationIconView> _navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;
  List<String> _titles;

  @override
  void initState() {
    super.initState();
    _titles = ['首页', '商城'];

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: ImageFactory.tabHomeN,
        title: new Text("首页"),
        activeIcon: ImageFactory.tabHomeS,
        vsync: this,
      ),
      new NavigationIconView(
        icon: ImageFactory.tabStoreN,
        title: new Text("商城"),
        activeIcon: ImageFactory.tabStoreS,
        vsync: this,
      ),
      // new NavigationIconView(
      //   icon: Image.asset('name'),
      //   title: new Text("购物车"),
      //   activeIcon: Image.asset('name'),
      //   vsync: this,
      // ),
      // new NavigationIconView(
      //   icon: Image.asset('name'),
      //   title: new Text("个人中心"),
      //   activeIcon: Image.asset('name'),
      //   vsync: this,
      // ),
    ];
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    _pageList = <StatefulWidget>[
      new HomePage(),
      new ShopPage(),
    ];
    _currentPage = _pageList[_currentIndex];
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    for (NavigationIconView view in _navigationViews) {
      view.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews
            .map((NavigationIconView navigationIconView) =>
                navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
        });

    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(title: Text(_titles[_currentIndex]), backgroundColor: Colors.black,),
        body: new Center(child: _currentPage),
        bottomNavigationBar: bottomNavigationBar,
        
      ),
      // theme: GlobalConfig.themeData
    );
  }
}
