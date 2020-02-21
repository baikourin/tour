import 'package:flutter/material.dart';
import 'package:tour/dao/travel_dao.dart';
import 'package:tour/dao/travel_tab_dao.dart';
import 'package:tour/model/travel_model.dart';
import 'package:tour/model/travel_tab_model.dart';

const TRAVEL_URL =
  'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  const TravelTabPage({Key key, this.travelUrl, this.groupChannelCode}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {


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
              }).toList())

          )
        ],
      ),
    );
  }
}
