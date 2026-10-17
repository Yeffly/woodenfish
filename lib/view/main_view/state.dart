import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../common/constant.dart';

class MainViewState {
  int count = 0;
  late String fishSkin = Constant.dataList.elementAt(0);
  int toneColour = 0; // 敲击音效下标（改成int，用来选knock1~knock5）
  double opacity = 0.0;

  String fuWnImage = Constant.fuWenList.first;
  bool autoKnock = false;
  bool muicKnock = false;
  bool isVibrate = true;
  double intervalTime = 1;
  Timer? timer;
  bool isAgree = false;

  late AudioPlayer audioPlayer;      // 木鱼敲击音效播放器
  late AudioPlayer bgMusicPlayer;    // 背景循环配乐播放器（改名，区分敲击播放器）

  // ✅ 两套音频独立索引，分开存储
  int selectedKnockIndex = 0;
  int selectedBgIndex = 0;

  late List<Widget> animatedList = [];
  int animatedRandoms = 0;
  var randomColors = Colors.white;

  var top = 200.0;
  var left = 0.0;
  var isTrue = false;
  var suspendedText = "";
  var stage = [200, 400, 600, 800, 1000, 1300, 1600, 1900, 2300, 2700];
  var stagePosition = 0;
  var shareFuImage;


  MainViewState() {
    audioPlayer = AudioPlayer();
    bgMusicPlayer = AudioPlayer();
  }
}
