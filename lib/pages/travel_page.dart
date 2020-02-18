import 'package:flutter/material.dart';
import 'package:tour/dao/travel_dao.dart';
import 'package:tour/dao/travel_tab_dao.dart';
import 'package:tour/model/travel_model.dart';
import 'package:tour/model/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _loadData();
    //    _controller = TabController(length: 0, vsync: this);
//    try {
//      TravelTabDao.fetch().then((TravelTabModel model) {
//      _controller = TabController(length: model.tabs.length, vsync: this); // fix tab label 空白问题
//        setState(() {
//          tabs = model.tabs;
//          travelTabModel = model;
//        });
//      });
//    } catch (e) {
//      print(e);
//    }

    super.initState();
  }

  //初始化tab数据
  void _loadData() async {
    _controller = TabController(length: 0, vsync: this);
    try {
      TravelTabModel model = await TravelTabDao.fetch();
      _controller = TabController(
        length: model.tabs.length, vsync: this); //fix tab label 空白问题
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    print(tabs[0]);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 20, 5),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Color(0xff2fcfbb),
                  width: 3,
                ),
                insets: EdgeInsets.only(bottom: 10)),
              tabs: tabs.map<Tab>((TravelTab tab) {
                return Tab(text: tab.labelName,);
              }).toList()),
          ),
          // 不用Flexible包裹的话，会是空白页。
          Flexible(
            child: TabBarView(
            controller: _controller,
            children: tabs.map((TravelTab tab){
              return Text(tab.groupChannelCode);
            }).toList(),)

          )
        ],
      ),
    );
  }
}
