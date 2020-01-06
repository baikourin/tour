import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
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

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url: json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar'],
    );
  }
}

