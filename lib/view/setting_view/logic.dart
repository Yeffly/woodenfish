import 'dart:async';
import 'package:get/get.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class SettingViewLogic extends GetxController {
  final SettingViewState state = SettingViewState();

  // 自动敲击定时器
  Timer? autoTimer;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    // 页面销毁，释放定时器
    autoTimer?.cancel();
    autoTimer = null;
    // ✅ 新增：释放输入框控制器，防止内存泄漏
    state.textEditingController.dispose();
    super.onClose();
  }

  Future<void> getData() async {
    // 读取敲击音色
    String toneStr = Application.getStorage.read(Constant.toneColourKey) ?? Constant.toneColour.first;
    state.toneColourIndex = Constant.toneColour.indexOf(toneStr);
    if(state.toneColourIndex == -1) state.toneColourIndex = 0;

    // 读取背景配乐
    String bgStr = Application.getStorage.read(Constant.bgSoundKey) ?? Constant.bgMusicList.first;
    state.bgMusicIndex = Constant.bgMusicList.indexOf(bgStr);
    if(state.bgMusicIndex == -1) state.bgMusicIndex = 0;

    // 自动敲击开关、敲击间隔
    state.switchAutoValue = Application.getStorage.read(Constant.autoKnockKey) ?? false;
    state.intervalTime = Application.getStorage.read(Constant.intervalTimeKey) ?? 1.0;

    // 自定义功德文字
    String suspended = Application.getStorage.read(Constant.suspendedKey) ?? "";
    state.textEditingController.text = suspended;

    // 读取配置完成后，如果自动敲击开启，启动定时器
    if(state.switchAutoValue){
      startAutoKnock();
    }

    update();
  }

  /// 启动自动敲击定时器
  void startAutoKnock() {
    autoTimer?.cancel(); // 先销毁旧定时器，防止多个Timer并行
    final int ms = (state.intervalTime * 1000).round();
    autoTimer = Timer.periodic(Duration(milliseconds: ms), (_) {
      // EventBus发送事件，首页接收执行敲击
      EventBus.getDefault().post(Constant.autoKnockKey);
    });
  }

  /// 选择敲击音色
  void selectTone(int index) {
    state.toneColourIndex = index;
    String value = Constant.toneColour[index];
    Application.getStorage.write(Constant.toneColourKey, value);
    EventBus.getDefault().post(Constant.toneColourKey);
    update();
  }

  /// 选择背景配乐
  void selectBgMusic(int index) {
    state.bgMusicIndex = index;
    String value = Constant.bgMusicList[index];
    Application.getStorage.write(Constant.bgSoundKey, value);
    EventBus.getDefault().post(Constant.bgSoundKey);
    update();
  }

  /// 保存自定义功德文字
  void saveSuspendedText(String text) {
    Application.getStorage.write(Constant.suspendedKey, text);
    EventBus.getDefault().post(Constant.suspendedKey);
  }

  /// 自动敲击开关切换
  void onAutoKnockChange(bool value) {
    state.switchAutoValue = value;
    Application.getStorage.write(Constant.autoKnockKey, value);
    EventBus.getDefault().post(Constant.autoKnockKey);

    if(value){
      startAutoKnock();
    }else{
      autoTimer?.cancel();
      autoTimer = null;
    }
    update();
  }

  /// 滑块松手回调：更新敲击间隔，保存本地，重启定时器
  void onIntervalChange(double value) {
    state.intervalTime = value;
    Application.getStorage.write(Constant.intervalTimeKey, value);
    EventBus.getDefault().post(Constant.intervalTimeKey);

    if(state.switchAutoValue){
      startAutoKnock();
    }
    update();
  }
}
