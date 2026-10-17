import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constant.dart';
import 'logic.dart';

class SettingViewPage extends StatelessWidget {
  SettingViewPage({super.key});

  final logic = Get.put(SettingViewLogic());
  final state = Get.find<SettingViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text("设置"),
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<SettingViewLogic>(builder: (_) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== 敲击音色选择 =====
              Text(
                "敲击音色",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              SizedBox(height: 12.w),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: List.generate(Constant.toneColour.length, (index) {
                  String item = Constant.toneColour[index];
                  bool selected = state.toneColourIndex == index;
                  return InkWell(
                    onTap: () {
                      logic.selectTone(index);
                    },
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: selected ? Colors.amber : Colors.white10,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: selected ? Colors.black : Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 30.w),

              // ===== 背景BGM选择 =====
              Text(
                "背景配乐",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              SizedBox(height: 12.w),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: List.generate(Constant.bgMusicList.length, (index) {
                  String item = Constant.bgMusicList[index];
                  bool selected = state.bgMusicIndex == index;
                  return InkWell(
                    onTap: () {
                      logic.selectBgMusic(index);
                    },
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: selected ? Colors.amber : Colors.white10,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          item,
                          style: TextStyle(
                            color: selected ? Colors.black : Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 30.w),

              // ===== 自定义功德文字 =====
              Text(
                "自定义功德文字",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              SizedBox(height: 12.w),
              TextField(
                controller: state.textEditingController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "不填则使用默认文字",
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
                onChanged: (value) {
                  logic.saveSuspendedText(value);
                },
              ),
              SizedBox(height: 30.w),

              // ===== 自动敲击 =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "自动敲击",
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  Switch(
                    value: state.switchAutoValue,
                    onChanged: (bool val) {
                      logic.onAutoKnockChange(val);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Text(
                "敲击间隔：${state.intervalTime.toStringAsFixed(1)} 秒",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              Slider(
                min: 1,
                max: 10,
                value: state.intervalTime,
                onChanged: (double val) {
                  logic.onIntervalChange(val);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
