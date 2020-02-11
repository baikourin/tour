import 'package:flutter/services.dart';

///百度ai语音flutter方法
class AsrManager {
  static const MethodChannel _channel = const MethodChannel('asr_plugin');

  ///録音開始
  static Future<String> start({Map params}) async {
    return await _channel.invokeMethod('start', params ?? {});
  }

  ///録音停止
  static Future<String> stop() async {
    return await _channel.invokeMethod('stop');
  }

  ///録音キャンセル
  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}
