import 'package:flutter/material.dart';

class SettingViewState {
  // 敲击音色索引
  int toneColourIndex = 0;
  // 背景配乐索引
  int bgMusicIndex = 0;
  // 自动敲击开关
  bool switchAutoValue = false;
  // 自动敲击间隔（秒）
  double intervalTime = 1.0;
  // 自定义功德文字输入框控制器
  final TextEditingController textEditingController = TextEditingController(text: "");

  SettingViewState() {}
}
