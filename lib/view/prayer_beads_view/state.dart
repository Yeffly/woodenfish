import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../common/constant.dart';
import '../../widgets/snowflake_painter.dart';

class PrayerBeadsViewState {
  final List<SnowSlake> snowflakes = List.generate(50, (index) => SnowSlake());
  // late String toneColour = Constant.toneColour.elementAt(0); // 冗余废弃，改用 selectedKnockIndex
  bool snowflakeValue = true;
  bool muicKnock = false;
  bool isVibrate = true;

  // 和木鱼页面保持一致：两套独立播放器
  late AudioPlayer bgMusicPlayer;
  late AudioPlayer audioPlayer;

  int selectedKnockIndex = 0;
  int selectedBgIndex = 0;

  List<int> stage = [200, 400, 600, 800, 1000, 1300, 1600, 1900, 2300, 2700];
  int count = 0;
  int stagePosition = 0;
  String suspendedText = "";
  String? shareFuImage;
  late String prayerBeadsSkin;

  ScrollController controller = ScrollController();
  late AnimationController gongdeController;


  PrayerBeadsViewState() {
    audioPlayer = AudioPlayer();
    bgMusicPlayer = AudioPlayer();
    // 初始化手串默认皮肤
    prayerBeadsSkin = Constant.prayerBeadsList.elementAt(0);
  }
}
