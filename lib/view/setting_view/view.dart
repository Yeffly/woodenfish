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
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        title: const Text(
          "设置",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: GetBuilder<SettingViewLogic>(
        builder: (_) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== 敲击音色 卡片 =====
                buildItemCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "敲击音色",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
                                color: selected ? Colors.amber : const Color(0xFF383838),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  item,
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
                SizedBox(height: 16.h),

                // ===== 背景配乐 卡片 =====
                buildItemCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "背景配乐",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
                                color: selected ? Colors.amber : const Color(0xFF383838),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  item,
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
                SizedBox(height: 16.h),

                // ===== 自定义功德文字 卡片【重点优化：缩小输入框高度】 =====
                buildItemCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "自定义功德文字",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        controller: state.textEditingController,
                        style: TextStyle(color: Colors.white, fontSize:15.sp),
                        // 单行输入框，缩小高度
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "不填则使用默认文字",
                          hintStyle: TextStyle(color: Colors.white54, fontSize:14.sp),
                          filled: true,
                          fillColor: const Color(0xFF333333),
                          contentPadding: EdgeInsets.symmetric(horizontal:12.w, vertical:10.h),
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
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ===== 自动敲击 卡片 =====
                buildItemCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "自动敲击",
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                          Switch(
                            value: state.switchAutoValue,
                            activeColor: Colors.amber,
                            activeTrackColor: Colors.amber.withOpacity(0.5),
                            inactiveTrackColor: const Color(0xFF383838),
                            onChanged: (bool val) {
                              logic.onAutoKnockChange(val);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "敲击间隔：${state.intervalTime.toStringAsFixed(1)} 秒",
                        style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                      SizedBox(height: 6.h),
                      Slider(
                        min: 1,
                        max: 10,
                        activeColor: Colors.amber,
                        inactiveColor: const Color(0xFF383838),
                        thumbColor: Colors.amber,
                        value: state.intervalTime,
                        // 拖动过程：只修改state预览值，删掉错误的update()
                        onChanged: (double val) {
                          state.intervalTime = val;
                        },
                        // 松手结束拖动，才执行保存+重启定时器
                        onChangeEnd: (double val) {
                          logic.onIntervalChange(val);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height:30.h),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 封装通用卡片组件，统一样式
  Widget buildItemCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B2B),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}
