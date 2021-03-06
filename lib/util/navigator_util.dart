import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigatorUtil {
  // ページ　ジャンプ
  static push(BuildContext context, Widget page) async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => page));
      return result;
  }
}

