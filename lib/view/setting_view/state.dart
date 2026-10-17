import 'package:flutter/material.dart';

import '../../utils/trie_note.dart';

class SettingViewState {
  var switchMusicValue = false;
  var switchAutoValue = false;
  var skinIndex = 0;
  var toneColourIndex = 0;
  // 新增背景配乐下标
  var bgMusicIndex = 0;
  var sliderValue = 1.0;
  var isAgree = false;
  var suspendedText = "";
  final TextEditingController textEditingController =
      TextEditingController(text: "");

  Trie trie = Trie();

  // AhoCorasick ac = AhoCorasick();
  SettingViewState() {}
}
