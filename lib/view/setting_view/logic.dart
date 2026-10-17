import 'dart:async';
import 'package:get/get.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class SettingViewLogic extends GetxController {
  final SettingViewState state = SettingViewState();

  // 新增：自动敲击定时器
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

    // 自动敲击
    state.switchAutoValue = Application.getStorage.read(Constant.autoKnockKey) ?? false;
    state.intervalTime = Application.getStorage.read(Constant.intervalTimeKey) ?? 1.0;

    // 自定义功德文字
    String suspended = Application.getStorage.read(Constant.suspendedKey) ?? "";
    state.textEditingController.text = suspended;

    // 新增：读取配置后，如果自动敲击是开启状态，则启动定时器
    if(state.switchAutoValue){
      startAutoKnock();
    }

    update();
  }

  /// 启动自动敲击定时器
  void startAutoKnock() {
    autoTimer?.cancel(); // 先销毁旧定时器，避免多个Timer同时运行
    autoTimer = Timer.periodic(Duration(milliseconds: (state.intervalTime * 1000).toInt()), (_) {
      // 发送事件，通知首页执行敲击动作（复用EventBus，不用引入其他logic）
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

  void saveSuspendedText(String text) {
    Application.getStorage.write(Constant.suspendedKey, text);
    EventBus.getDefault().post(Constant.suspendedKey);
  }

  void onAutoKnockChange(bool value) {
    state.switchAutoValue = value;
    Application.getStorage.write(Constant.autoKnockKey, value);
    EventBus.getDefault().post(Constant.autoKnockKey);

    // 开关变化，启动/关闭定时器
    if(value){
      startAutoKnock();
    }else{
      autoTimer?.cancel();
      autoTimer = null;
    }
    update();
  }

  /// 【修改】滑块松手之后才调用这个方法，保存并重启定时器
  void onIntervalChange(double value) {
    state.intervalTime = value;
    Application.getStorage.write(Constant.intervalTimeKey, value);
    EventBus.getDefault().post(Constant.intervalTimeKey);

    // 如果自动敲击正在开启，立刻重启定时器，应用新间隔
    if(state.switchAutoValue){
      startAutoKnock();
    }
    update();
  }
}
