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
            // 滑动实时预览，保留一位小数，消除浮点数抖动
            double fixedVal = double.parse(val.toStringAsFixed(1));
            state.intervalTime = fixedVal;
            logic.update();
          },
          onChangeEnd: (double val) {
            // 手指松开后才写入存储、发事件总线
            double fixedVal = double.parse(val.toStringAsFixed(1));
            logic.onIntervalChange(fixedVal);
          },
        ),
      ),
    ],
  ),
),
