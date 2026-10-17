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
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: Text(
          "设置",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
      ),
      body: GetBuilder<SettingViewLogic>(
        builder: (_) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========== 敲击音色 卡片 ==========
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle("敲击音色"),
                      SizedBox(height: 14.h),
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 12.w,
                        children: List.generate(Constant.toneColour.length, (index) {
                          String item = Constant.toneColour[index];
                          bool selected = state.toneColourIndex == index;
                          return InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () => logic.selectTone(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              width: 84.w,
                              height: 84.w,
                              decoration: BoxDecoration(
                                color: selected ? Colors.amber : const Color(0xFF2C2C2C),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected ? Colors.black : Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                // ========== 背景配乐 卡片 ==========
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle("背景配乐"),
                      SizedBox(height: 14.h),
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 12.w,
                        children: List.generate(Constant.bgMusicList.length, (index) {
                          String item = Constant.bgMusicList[index];
                          bool selected = state.bgMusicIndex == index;
                          return InkWell(
                            borderRadius: BorderRadius.circular(12.r),
                            onTap: () => logic.selectBgMusic(index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              width: 84.w,
                              height: 84.w,
                              decoration: BoxDecoration(
                                color: selected ? Colors.amber : const Color(0xFF2C2C2C),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selected ? Colors.black : Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                // ========== 自定义功德文字 卡片 ==========
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionTitle("自定义功德文字"),
                      SizedBox(height: 14.h),
                      TextField(
                        controller: state.textEditingController,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "不填则使用默认文字",
                          hintStyle: TextStyle(color: Colors.white54, fontSize: 15.sp),
                          filled: true,
                          fillColor: const Color(0xFF242424),
                          // 重点：控制输入框高度，解决输入框过高问题
                          contentPadding: EdgeInsets.symmetric(horizontal:14.w, vertical:10.h),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.amber, width:1.4),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onChanged: (value) => logic.saveSuspendedText(value),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.h),

                // ========== 自动敲击 卡片 ==========
                buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildSectionTitle("自动敲击"),
                          Switch(
                            value: state.switchAutoValue,
                            activeColor: Colors.amber,
                            activeTrackColor: Colors.amber.withOpacity(0.5),
                            inactiveTrackColor: const Color(0xFF383838),
                            onChanged: (bool val) => logic.onAutoKnockChange(val),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "敲击间隔：${state.intervalTime.toStringAsFixed(1)} 秒",
                        style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: double.infinity,
                        child: Slider(
                          min: 1,
                          max: 10,
                          activeColor: Colors.amber,
                          inactiveColor: const Color(0xFF383838),
                          thumbColor: Colors.amber,
                          value: state.intervalTime,
                          onChanged: (double val) {
                            double fixedVal = double.parse(val.toStringAsFixed(1));
                            state.intervalTime = fixedVal;
                            logic.update();
                          },
                          onChangeEnd: (double val) {
                            double fixedVal = double.parse(val.toStringAsFixed(1));
                            logic.onIntervalChange(fixedVal);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 通用卡片
  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: child,
    );
  }

  /// 板块标题统一样式
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
