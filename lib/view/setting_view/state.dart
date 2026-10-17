import 'package:flutter/material.dart';

// import '../../utils/trie_note.dart'; // 离线精简版，移除不需要的字典树

class SettingViewState {
  // var switchMusicValue = false; // 废弃未使用
  // var switchVibrateValue = false; // 废弃未使用
  // var skinIndex = 0; // 废弃未使用
  int toneColourIndex = 0;
  int bgMusicIndex = 0;
  // var sliderValue = 1.0; // 废弃未使用
  bool switchAutoValue = false;
  // var isAgree = false; // 废弃未使用
  // var suspendedText = ""; // 废弃，功德文字由输入框控制器管理
  double intervalTime = 1.0;
  final TextEditingController textEditingController = TextEditingController(text: "");

  // Trie trie = Trie(); // 离线精简版移除，不需要字典树

  SettingViewState() {}
}
