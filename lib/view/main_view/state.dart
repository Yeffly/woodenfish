import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../common/constant.dart';

class MainViewState {
  int count = 0;
  late String fishSkin = Constant.dataList.elementAt(0);
  // int toneColour = 0; // 冗余，已废弃，现在使用 selectedKnockIndex
  double opacity = 0.0;

  String fuWnImage = Constant.fuWenList.first;
  bool autoKnock = false;
  bool muicKnock = false;
  bool isVibrate = true;
  double intervalTime = 1;
  Timer? timer;
  bool isAgree = false;

  late AudioPlayer audioPlayer;      // 木鱼敲击音效播放器
  late AudioPlayer bgMusicPlayer;    // 背景循环配乐播放器

  // ✅ 两套音频独立索引，分开存储
  int selectedKnockIndex = 0;
  int selectedBgIndex = 0;

  late List<Widget> animatedList = [];
  int animatedRandoms = 0;
  Color randomColors = Colors.white;

  double top = 200.0;
  double left = 0.0;
  bool isTrue = false;
  String suspendedText = "";
  List<int> stage = [200, 400, 600, 800, 1000, 1300, 1600, 1900, 2300, 2700];
  int stagePosition = 0;
  String? shareFuImage;


  MainViewState() {
    audioPlayer = AudioPlayer();
    bgMusicPlayer = AudioPlayer();
  }
}
