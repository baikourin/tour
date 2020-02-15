package com.kourim.tour;

import android.os.Bundle;

import com.kourim.plugin.asr.AsrPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    // 注册自己的plugin
    registerSelfPlugin();
  }

  private void registerSelfPlugin() {
    AsrPlugin.registerWith(registrarFor("com.kourim.plugin.asr.AsrPlugin"));
  }
}
