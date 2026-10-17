import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../common/constant.dart';
import '../../widgets/snowflake_painter.dart';

class PrayerBeadsViewState {
  final List<SnowSlake> snowflakes = List.generate(50, (index) => SnowSlake());
  late String toneColour = Constant.toneColour.elementAt(0);
  bool snowflakeValue = true;
  bool muicKnock = false;

  bool isVibrate = true;

  // 修改：重命名为 bgMusicPlayer，新增音频选择索引，和MainView对齐
  late AudioPlayer bgMusicPlayer;
  late AudioPlayer audioPlayer;

  var selectedKnockIndex = 0;
  var selectedBgIndex = 0;

  var stage = [200, 400, 600, 800, 1000, 1300, 1600, 1900, 2300, 2700];
  var count = 0;
  var stagePosition = 0;
  var suspendedText = "";

  var shareFuImage;

  var prayerBeadsSkin;

  ScrollController controller = ScrollController();
  late AnimationController gongdeController;


  PrayerBeadsViewState() {
    audioPlayer = AudioPlayer();
    bgMusicPlayer = AudioPlayer();
  }
}
