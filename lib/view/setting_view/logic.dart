import 'package:get/get.dart';

import '../../common/application.dart';
import '../../common/constant.dart';
import '../../utils/event_bus.dart';
import 'state.dart';

class SettingViewLogic extends GetxController {
  final SettingViewState state = SettingViewState();

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async {
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

    update();
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
    update();
  }

  void onIntervalChange(double value) {
    state.intervalTime = value;
    Application.getStorage.write(Constant.intervalTimeKey, value);
    EventBus.getDefault().post(Constant.intervalTimeKey);
    update();
  }
}
