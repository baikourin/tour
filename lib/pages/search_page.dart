import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour/model/common_model.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

///搜索页面
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  SearchPage(
    {Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint})
    : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showResult = '';
  Future<CommonModel> fetchPost() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Http'),
        ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              fetchPost().then((CommonModel value) {
                setState(() {
                  showResult =
                  '请求结果：\nhideAppBar：${value.hideAppBar}\nicon：${value.icon}';
                });
              });
            },
            child: Text(
              '点我',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Text(showResult)
        ],
      ),
    );
  }
}


