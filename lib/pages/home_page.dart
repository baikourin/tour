import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tour/dao/home_dao.dart';
import 'package:tour/model/common_model.dart';
import 'package:tour/model/grid_nav_model.dart';
import 'package:tour/model/home_model.dart';
import 'package:tour/model/sales_box_model.dart';
import 'package:tour/pages/search_page.dart';
import 'package:tour/pages/speak_page.dart';
import 'package:tour/util/navigator_util.dart';
import 'package:tour/widget/grid_nav.dart';
import 'package:tour/widget/local_nav.dart';
import 'package:tour/widget/sales_box.dart';
import 'package:tour/widget/search_bar.dart';
import 'package:tour/widget/sub_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

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
  SalesBoxModel salesBox;
  String resultString = "";
  String city = '西安市';

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
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        salesBox = model.salesBox;
        resultString = json.encode(model.config);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }

  }

  //跳转到城市列表
  void _jumpToCity() async {
    final result = await NavigatorUtil.push(context, null);
    setState(() {
      city = result;
    });
  }

  //跳转搜索页面
  void _jumpToSearch() {
    NavigatorUtil.push(
      context,
      SearchPage(
        hint: SEARCH_BAR_DEFAULT_TEXT,
      ));
  }

  //跳转语音识别页面
  void _jumpToSpeak() {
    NavigatorUtil.push(
      context,
      SpeakPage()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xfff2f2f2),
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
                child: _listView,
                )
            ),
            // 透明度设定
            _appBar
          ],
        )
    );
  }

  Widget get _listView {
    return ListView(
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
      ],
    );
  }

  /* appBar */
Widget get _appBar {
  return Column(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          //TODO gradient斜坡
          gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)
          ),
          // TODO
          child: SearchBar(
            searchBarType: appBarAlpha > 0.2
                ? SearchBarType.homeLight
                : SearchBarType.home,
            //TODO
            inputBoxClick: _jumpToSearch,
            speakClick: _jumpToSpeak,
            defaultText: SEARCH_BAR_DEFAULT_TEXT,
            leftButtonClick: _jumpToCity,
            city: city,
          ),
        ),
      ),
      Container(
        height: appBarAlpha>0.2 ? 0.5 : 0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 0.5)
          ]
        ),
      )
    ],
  );
}
}
