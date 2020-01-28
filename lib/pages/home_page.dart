import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tour/dao/home_dao.dart';
import 'package:tour/model/common_model.dart';
import 'package:tour/model/grid_nav_model.dart';
import 'package:tour/model/home_model.dart';
import 'package:tour/widget/grid_nav.dart';
import 'package:tour/widget/local_nav.dart';
import 'package:tour/widget/sub_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];
  double appBarAlpha = 0;
  List<CommonModel> localNavList = []; // local导航
  GridNavModel gridNav; // 网络卡片
  List<CommonModel> subNavList = []; // 活动导航
  String resultString = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  _onScroll(offset){
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print('appBarAlpha:'+ appBarAlpha.toString());
  }

  loadData() async {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      // Stack前面的元素叠在下面，后面的元素叠在上面
        body: Stack(
          children: <Widget>[
            // 移除空白
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                  // 列表每次滚动的时候，都会回调这个函数
                  onNotification: (scrollNotification){
                    // scrollNotification.depth == 0 表示监听第0个元素滚动，也就是ListView的滚动，不监听Swiper的滚动，监听最外层widget的滚动
                    if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                      //滚动且是列表滚动的时候
                      _onScroll(scrollNotification.metrics.pixels);
                    }
                    return;
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 160,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      /*localのナビ*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(localNavList: localNavList),
                      ),
                      /*网络卡片*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: GridNav(gridNav: gridNav),
                      ),
                      /*活动导航*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: SubNav(subNavList: subNavList),
                      ),
                      /*底部卡片*/
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: SalesBox(salesBox: salesBox),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(title: Text(resultString),
                        ),
                      )
                    ],
                  ),
                )
            ),
            // 透明度设定
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text('Home'),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
