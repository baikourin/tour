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
  void initState() {
    // AnimationController 动画控制器，动画的开始、结束、停止、反向均由它控制，
    //  方法对应为：forward、stop、reverse
    controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
