import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_runkang/shared/image_factory.dart';
import 'package:flutter_runkang/widgets/point_cell.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/icon_text_button.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    return Container(
      color: Colors.black12,
      child: Column(children: [
        Container(
          width: size.width,
          height: 200,
          child: Swiper.children(
            children: [
              ImageFactory.head,
              ImageFactory.head1,
              ImageFactory.head2
            ],
            autoplay: true,
            pagination: SwiperPagination(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 2,
                      height: 15,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '精选消息',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: Text(
                      '云生态空调系统系列研发成功 即将全球同步上线 敬请期待！！',
                      style: TextStyle(fontSize: 12),
                      maxLines: 2,
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 0.5,
                  color: Colors.black12,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconTextButton(
                        text: '健康生活',
                        image: ImageFactory.life,
                        onTap: () {
                          print('object');
                        },
                      ),
                      IconTextButton(
                        text: '美食养生',
                        image: ImageFactory.message,
                        onTap: () {
                          print('object');
                        },
                      ),
                      IconTextButton(
                        text: '设备',
                        image: ImageFactory.device,
                        onTap: () {
                          print('object');
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 2,
                    height: 15,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '积分管理',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PointCell(
                      text: '签到领积分',
                      subText: '积分兑海量商品',
                      image: ImageFactory.signin,
                      onTap: () {
                        print('object');
                      },
                    ),
                    Container(
                      width: 0.5,
                      height: 40,
                      color: Colors.black12,
                    ),
                    PointCell(
                      text: '分享奖励计划',
                      subText: '积分规则全面解析',
                      image: ImageFactory.hot,
                      onTap: () {
                        print('object');
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
