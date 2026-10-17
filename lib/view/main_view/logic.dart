import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../generated/l10n.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class MainViewLogic extends GetxController with SingleGetTickerProviderMixin {
  final MainViewState state = MainViewState();

  late Animation<double> fuAnimation;
  late AnimationController fuController;
  late Animation<double> fishSkinAnimation;
  late AnimationController fishSkinController;
  late Animation<double> waterAnimation;
  late AnimationController waterController;
  late Animation<double> floatTextAnimation;
  late AnimationController floatTextController;
  late Animation<Offset> floatTextTransitionAnimation;
  late AnimationController floatTextTransitionController;

  late AnimationController jiFuController;

  // ========== 本地音频资源定义 ==========
  // 敲击音效 WAV
  final List<String> knockSoundList = [
    "audio/knock/knock1.wav",
    "audio/knock/knock2.wav",
    "audio/knock/knock3.wav",
    "audio/knock/knock4.wav",
    "audio/knock/knock5.wav",
  ];
  // 背景循环音 MP3
  final List<String> bgSoundList = [
    "audio/bg/bg1.mp3",
    "audio/bg/bg2.mp3",
    "audio/bg/bg3.mp3",
    "audio/bg/bg4.mp3",
    "audio/bg/bg5.mp3",
  ];

  @override
  void onInit() {
    super.onInit();
    jiFuController = AnimationController(vsync: this);
    fuController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    fuAnimation = Tween(begin: 0.0, end: 1.0).animate(fuController);
    fuAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fuController.reverse();
      }
    });

    fishSkinController = AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    fishSkinAnimation = Tween(begin: 1.0, end: 0.98).animate(fishSkinController);
    fishSkinAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fishSkinController.reverse();
      }
    });

    waterController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    waterAnimation = Tween(begin: 0.0, end: 0.65).animate(waterController);
    waterAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        waterController.reset();
      }
    });

    floatTextController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    floatTextAnimation = Tween(begin: 0.0, end: 1.0).animate(floatTextController);
    floatTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        floatTextController.reset();
      }
    });

    floatTextTransitionController = AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    floatTextTransitionAnimation = Tween(begin: Offset(0, 1), end: Offset(0, -2)).animate(floatTextTransitionController);
    floatTextTransitionAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        floatTextTransitionController.reset();
      }
    });

    EventBus.getDefault().register(null, (event) {
      var read = Application.getStorage.read(event.toString()) ?? "";
      switch (event) {
        case Constant.autoKnockKey:
          state.autoKnock = read;
          if (state.autoKnock) {
            startTimer();
          } else {
            cancelTimer();
          }
          break;
        case Constant.musicKey:
          state.muicKnock = read;
          if (state.muicKnock) {
            state.bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
            state.bgMusicPlayer.play(AssetSource(bgSoundList[state.selectedBgIndex]), volume:0.5);
          }else{
            state.bgMusicPlayer.stop();
          }
          break;
        case Constant.skinKey:
          state.fishSkin = Constant.dataList[read];
          break;
        case Constant.toneColourKey:
          int knockIdx = Constant.toneColour.indexOf(read);
          if(knockIdx != -1){
            state.selectedKnockIndex = knockIdx;
          }
          break;
        case Constant.bgSoundKey:
          int bgIdx = Constant.bgMusicList.indexOf(read);
          if(bgIdx != -1){
            state.selectedBgIndex = bgIdx;
            if(state.muicKnock){
              state.bgMusicPlayer.stop();
              state.bgMusicPlayer.play(AssetSource(bgSoundList[bgIdx]), volume:0.5);
              state.bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
            }
          }
          break;
        case Constant.suspendedKey:
          state.suspendedText = read;
          break;
        case Constant.fuKey:
          state.fuWnImage = Constant.fuWenList[read];
          break;
      }
      update();
    });
  }

  Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  getData() async {
    var s = Application.getStorage.read(Constant.countKey) ?? 0;
    var stage = Application.getStorage.read(Constant.stagePositionKey) ?? 0;
    state.stagePosition = stage;
    state.isVibrate = Application.getStorage.read(Constant.vibrateKey) ?? true;
    state.count = s;
    var skin = Application.getStorage.read(Constant.skinKey) ?? 0;
    state.fishSkin = Constant.dataList[skin];
    var fuwen = Application.getStorage.read(Constant.fuKey) ?? 0;
    state.fuWnImage = Constant.fuWenList[fuwen];

    // 读取敲击音效
    String knockStr = Application.getStorage.read(Constant.toneColourKey) ?? Constant.toneColour.first;
    int knockIndex = Constant.toneColour.indexOf(knockStr);
    state.selectedKnockIndex = knockIndex == -1 ? 0 : knockIndex;

    // 读取背景音【全局统一 bgSoundKey】
    String bgStr = Application.getStorage.read(Constant.bgSoundKey) ?? Constant.bgMusicList.first;
    int bgIndex = Constant.bgMusicList.indexOf(bgStr);
    state.selectedBgIndex = bgIndex == -1 ? 0 : bgIndex;

    double interval = Application.getStorage.read(Constant.intervalTimeKey) ?? 1.0;
    if (interval >= 1) {
      state.intervalTime = interval;
    }
    bool auto = Application.getStorage.read(Constant.autoKnockKey) ?? false;
    state.autoKnock = auto;
    if (state.autoKnock) {
      startTimer();
    } else {
      cancelTimer();
    }

    // 背景音乐开关
    bool bgMusicOpen = Application.getStorage.read(Constant.musicKey) ?? false;
    state.muicKnock = bgMusicOpen;
    if (bgMusicOpen) {
      await state.bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await state.bgMusicPlayer.play(AssetSource(bgSoundList[state.selectedBgIndex]), volume:0.5);
    }else{
      await state.bgMusicPlayer.stop();
    }

    state.isAgree = true;

    var suspendedKey = Application.getStorage.read(Constant.suspendedKey) ?? "";
    if (suspendedKey.isNotEmpty) {
      state.suspendedText = suspendedKey;
    }

    update();
  }

  void startTimer() {
    Duration duration = Duration(seconds: state.intervalTime.toInt());
    cancelTimer();
    state.timer = Timer.periodic(duration, (timer) {
      startKnock();
    });
  }

  void startKnock() async {
    await state.audioPlayer.stop();
    await state.audioPlayer.play(AssetSource(knockSoundList[state.selectedKnockIndex]), volume: 1.0);

    state.count += 1;
    Application.getStorage.write(Constant.countKey, state.count);
    fishSkinController.forward();
    waterController.forward();
    floatTextController.forward();
    floatTextTransitionController.forward();
    var random = Random();
    state.top = random.nextInt(230 - 200) + 200;
    state.left = random.nextInt(Get.width.toInt() - 50).toDouble();
    state.randomColors = getRandomColor();
    var canVibrate = await Vibrate.canVibrate;
    if (canVibrate && state.isVibrate) {
      Vibrate.feedback(FeedbackType.success);
    }
    if (state.count >= getStageContent()) {
      jiFuController.reverse();
    }
    update();
  }

  void cancelTimer() {
    state.timer?.cancel();
  }

  muicOpen() async {
    state.muicKnock = !state.muicKnock;
    Application.getStorage.write(Constant.musicKey, state.muicKnock);
    if (state.muicKnock) {
      await state.bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
      await state.bgMusicPlayer.play(AssetSource(bgSoundList[state.selectedBgIndex]), volume:0.5);
    } else {
      await state.bgMusicPlayer.stop();
    }
    update();
  }

  Future<void> changeKnockTone(int index) async {
    if(index <0 || index >= knockSoundList.length) return;
    state.selectedKnockIndex = index;
    String toneStr = Constant.toneColour[index];
    Application.getStorage.write(Constant.toneColourKey, toneStr);
    update();
  }

  Future<void> changeBgTone(int index) async {
    if(index <0 || index >= bgSoundList.length) return;
    state.selectedBgIndex = index;
    String bgStr = Constant.bgMusicList[index];
    Application.getStorage.write(Constant.bgSoundKey, bgStr);
    if(state.muicKnock){
      await state.bgMusicPlayer.stop();
      await state.bgMusicPlayer.play(AssetSource(bgSoundList[index]), volume:0.5);
      await state.bgMusicPlayer.setReleaseMode(ReleaseMode.loop);
    }
    update();
  }

  void vibrateOpen() {
    state.isVibrate = !state.isVibrate;
    Application.getStorage.write(Constant.vibrateKey, state.isVibrate);
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    state.audioPlayer.dispose();
    state.bgMusicPlayer.dispose();
    fuController.dispose();
    fishSkinController.dispose();
    waterController.dispose();
    floatTextController.dispose();
    floatTextTransitionController.dispose();
    jiFuController.dispose();
    cancelTimer();
    super.onClose();
  }

  // 空函数移除
  // show() {
  //   return;
  // }

  String content() {
    if (state.suspendedText.isNotEmpty) {
      return state.suspendedText;
    } else {
      return S.of(Get.context!).meritsAndVirtues;
    }
  }

  int getStageContent() {
    return state.stage[state.stagePosition];
  }

  double getProgss() {
    var progss = state.count / state.stage[state.stagePosition];
    return progss;
  }

  jufuClick() {
    if (state.count > getStageContent()) {
      state.shareFuImage = Constant.fuList[Random().nextInt(Constant.fuList.length)]['bg'];
      showFu();
      jiFuController.stop();
      state.stagePosition += 1;
      Application.getStorage.write(Constant.stagePositionKey, state.stagePosition);
    }
  }

  updatesData() {
    getData();
  }

showFu() {
  return showGeneralDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400.w,
              constraints: BoxConstraints(minHeight: 720.w, maxHeight: 800.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/${state.shareFuImage}"),
                    fit: BoxFit.contain,
                    height: 600.w,
                  )
                      .animate(adapter: ValueAdapter(0.5))
                      .shimmer(
                        colors: [
                          const Color(0xFFFFFF00),
                          const Color(0xFF00FF00),
                          const Color(0xFF00FFFF),
                          const Color(0xFF0033FF),
                          const Color(0xFFFF00FF),
                          const Color(0xFFFF0000),
                          const Color(0xFFFFFF00),
                        ],
                      )
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .saturate(delay: Duration(seconds: 1), duration: Duration(seconds: 2))
                      .then()
                      .fadeOut()
                      .animate()
                      .effect(duration: 3000.ms)
                      .effect(delay: 750.ms, duration: 1000.ms)
                      .slideX(begin: 1)
                      .flipH(begin: -1, alignment: Alignment.centerRight)
                      .scaleXY(begin: 0.75, curve: Curves.easeInOutQuad)
                      .untint(begin: 0.6),
                ],
              ),
            ),
            SizedBox(height: 20.w),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image(
                image: AssetImage("assets/images/ic_close.png"),
                fit: BoxFit.contain,
                height: 64.w,
                width: 64.w,
              )
            )
          ],
        );
      });
}
}
