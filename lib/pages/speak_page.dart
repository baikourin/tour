import 'package:flutter/material.dart';
import 'package:tour/pages/search_page.dart';
import 'package:tour/plugin/asr_manager.dart';
import 'package:tour/util/navigator_util.dart';

///语言识别page
class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
  with SingleTickerProviderStateMixin {
  String speakTips = '长按说话';
  String speakResult = '';
  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

