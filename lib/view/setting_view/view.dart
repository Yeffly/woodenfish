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
        elevation: 0, // 移除阴影，和深色背景融合
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
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: List.generate(Constant.toneColour.length, (index) {
                  String item = Constant.toneColour[index];
                  bool selected = state.toneColourIndex == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      logic.selectTone(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
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
              SizedBox(height: 30.h),

              // ===== 背景BGM选择 =====
              Text(
                "背景配乐",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.w,
                children: List.generate(Constant.bgMusicList.length, (index) {
                  String item = Constant.bgMusicList[index];
                  bool selected = state.bgMusicIndex == index;
                  return InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      logic.selectBgMusic(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
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
              SizedBox(height: 30.h),

              // ===== 自定义功德文字 =====
              Text(
                "自定义功德文字",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: state.textEditingController,
                style: TextStyle(color: Colors.white, fontSize:16.sp),
                decoration: InputDecoration(
                  hintText: "不填则使用默认文字",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.white38),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.white38),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.amber, width:1.5),
                  ),
                ),
                onChanged: (value) {
                  logic.saveSuspendedText(value);
                },
              ),
              SizedBox(height: 30.h),

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
                    activeColor: Colors.amber,
                    inactiveTrackColor: Colors.white24,
                    onChanged: (bool val) {
                      logic.onAutoKnockChange(val);
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "敲击间隔：${state.intervalTime.toStringAsFixed(1)} 秒",
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              Slider(
                min: 1,
                max: 10,
                activeColor: Colors.amber,
                inactiveColor: Colors.white24,
                thumbColor: Colors.amber,
                value: state.intervalTime,
                onChanged: (double val) {
                  logic.onIntervalChange(val);
                },
              ),
              SizedBox(height:20.h),
            ],
          ),
        );
      }),
    );
  }
}
