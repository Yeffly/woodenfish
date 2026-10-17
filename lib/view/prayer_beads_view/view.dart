import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PrayerBeadsViewPage extends StatelessWidget {
  PrayerBeadsViewPage({Key? key}) : super(key: key);

  final logic = Get.put(PrayerBeadsViewLogic());
  final state = Get.find<PrayerBeadsViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerBeadsViewLogic>(builder: (logics) {
      return Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: [
          // 手串滚动区域
          NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              logic.startKnock();
              return true;
            },
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0),
              itemExtent: 200.w,
              itemCount: 1000,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.only(top: 10.w),
                child: Image(
                  height: 200.w,
                  image: AssetImage("assets/images/${state.prayerBeadsSkin}"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          leftTopMenu(),
          widgetProgss(),
          widgetGongde(),
        ],
      );
    });
  }

  Widget widgetGongde() {
    return Positioned(
      top: Get.height / 2,
      left: Get.width / 2 + 130.w,
      child: Text(
        "+1",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 36.0.sp,
        ),
      ).animate(
        controller: state.gongdeController,
      ).fadeIn(curve: Curves.easeInOutQuint).moveY(end: -10),
    );
  }

  Widget leftTopMenu() {
    return Positioned(
      top: Get.statusBarHeight,
      left: 20.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              logic.muicOpen();
            },
            child: Icon(
              state.muicKnock ? Icons.headset_off_outlined : Icons.headset_mic_outlined,
              size: 50.w,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.w),
          GestureDetector(
            onTap: () {
              logic.vibrateOpen();
            },
            child: Icon(
              state.isVibrate ? Icons.vibration_outlined : Icons.smartphone_outlined,
              size: 50.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetProgss() {
    return Positioned(
      top: 100.h,
      right: 30.w,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: CircularProgressIndicator(
                  value: logic.getProgss(),
                  strokeWidth: 12.w,
                  color: Colors.amber,
                  backgroundColor: Colors.white54,
                ),
              ),
              InkWell(
                onTap: () => logic.jufuClick(),
                child: Text(
                  "集福",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                  ),
                ).animate(controller: logic.jiFuController).shimmer(
                  duration: 1200.ms,
                  color: const Color(0xFF80DDFF),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${state.count}/${logic.getStageContent()}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
