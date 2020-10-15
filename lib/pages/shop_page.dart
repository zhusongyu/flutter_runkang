import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_runkang/coordinator/application.dart';
import 'package:flutter_runkang/requests/routes.dart';
import 'package:flutter_runkang/shared/image_factory.dart';
import 'package:flutter_runkang/widgets/pager_tab.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopPageState();
  }
}

class ShopPageState extends State<ShopPage> {
  final PageController topPageControl = new PageController();

  final List<String> tab = ["首页", "生态治理", "家庭园艺"];
  @override
  Widget build(BuildContext context) {
    return new PagerTab(
      type: PagerTab.TOP_TAB,
      tabItems: _renderTab(),
      tabViews: _renderPage(),
      topPageControl: topPageControl,
      indicatorColor: Colors.black,
    );
  }

  _renderTab() {
    List<Widget> list = new List();
    for (int i = 0; i < tab.length; i++) {
      list.add(new FlatButton(
          onPressed: () {
            topPageControl.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            tab[i],
            maxLines: 1,
            style: TextStyle(color: Colors.black),
          )));
    }
    return list;
  }

  _renderPage() {
    return [
      new ShopContent(),
      new ShopContent(),
      new ShopContent(),
    ];
  }
}

class ShopContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopContentState();
  }
}

class ShopContentState extends State<ShopContent> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      controller: _refreshController,
      onLoading: () {
        Future.delayed(Duration(milliseconds: 3000));
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
      onRefresh: () {
        Future.delayed(Duration(milliseconds: 3000));
        _refreshController.refreshCompleted();
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.95),
        itemBuilder: (BuildContext context, int index) {
          return ShopItem();
        },
        itemCount: 10,
      ),
    );
    // RefreshConfiguration(
    //     footerTriggerDistance: 15,
    //     dragSpeedRatio: 0.91,
    //     headerBuilder: () => MaterialClassicHeader(),
    //     footerBuilder: () => ClassicFooter(),
    //     enableLoadingWhenNoData: false,
    //     shouldFooterFollowWhenNotFull: (state) {
    //       // If you want load more with noMoreData state ,may be you should return false
    //       return false;
    //     },
    //     child: ScrollConfiguration(
    //         behavior: ScrollBehavior(),
    //         child: GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //               crossAxisCount: 2,
    //               crossAxisSpacing: 5,
    //               mainAxisSpacing: 5,
    //               childAspectRatio: 0.95),
    //           itemBuilder: (BuildContext context, int index) {
    //             return ShopItem();
    //           },
    //           itemCount: 10,
    //         )));
  }
}

class ShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // final _counter = Provider.of<MyModel>(context);

    return GestureDetector(
      onTap: () {
        Application.router.navigateTo(context, Routes.ShopDetailWeb, transition: TransitionType.cupertino);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 150,
            child: ImageFactory.head,
          ),
          Text(
            ' 商品名称',
            textAlign: TextAlign.left,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' ¥10',
                style: TextStyle(color: Colors.red),
              ),
              Text(
                '0积分 ',
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
        ],
      ),
    );
  }
}
