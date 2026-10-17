import 'package:flutter/material.dart';

import '../../utils/trie_note.dart';

class SettingViewState {
  var switchMusicValue = false;
  var switchVibrateValue = false;
  var skinIndex = 0;
  var toneColourIndex = 0;
  var bgMusicIndex = 0;
  var sliderValue = 1.0;
  var switchAutoValue = false;
  var isAgree = false;
  var suspendedText = "";
  final TextEditingController textEditingController =
      TextEditingController(text: "");

  Trie trie = Trie();

  SettingViewState() {}
}
