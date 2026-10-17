class Constant {
  static bool isClickAgreement = true;
  static const String isAgree = "is_agree";
  static const String countKey = "count_key";
  static const String musicKey = "music_key";
  static const String vibrateKey = "vibrate_key";
  static const String skinKey = "skin_key";
  static const String isSkinLockKey = "isSkinLockKey";
  static const String fuKey = "fu_key";
  static const String toneColourKey = "tone_colour_key";
  static const String bgSoundKey = "bg_sound_key";
  static const String intervalTimeKey = "interval_time_key";
  static const String autoKnockKey = "auto_knock_key";
  static const String suspendedKey = "suspended_key";
  static const String stagePositionKey = "stage_position_key";

  static const List<String> dataList = [
    "hd.png",
    "h8.png",
    "hg.png",
    "h6.png",
    "h5.png",
    "h_.png",
    "hb.png",
  ];

  static const List<String> fuWenList = [
    "fi.png",
    "fk.png",
    "fm.png",
    "fo.png",
    "fq.png",
    "fj.png",
    "fl.png",
    "fn.png",
    "fp.png",
    "fr.png",
  ];

  // 5个本地敲击音色
  static const List<String> toneColour = [
    "01",
    "02",
    "03",
    "04",
    "05",
  ];

  // 5个本地BGM资源数组
  static const List<String> bgMusicList = [
    "bg01",
    "bg02",
    "bg03",
    "bg04",
    "bg05",
  ];

  static const List<Map<String,dynamic>> muyuList = [
    {
      "bg": "hd.png",
      "isLock": false,
      "price": '',
      "title": "紫香檀木鱼",
    },
    {
      "bg": "h8.png",
      "isLock": true,
      "price": '',
      "title": "金色紫檀香木鱼",
    },
    {
      "bg": "hg.png",
      "isLock": true,
      "price": '',
      "title": "白色木鱼",
    },
    {
      "bg": "h6.png",
      "isLock": true,
      "price": '',
      "title": "轻木鱼",
    },
    {
      "bg": "h5.png",
      "isLock": true,
      "price": '',
      "title": "蓝色木鱼",
    },
    {
      "bg": "h_.png",
      "isLock": true,
      "price": '',
      "title": "粉色木鱼",
    },
    {
      "bg": "hb.png",
      "isLock": true,
      "price": '',
      "title": "圣诞木鱼",
    }
  ];

  static const List<Map<String,dynamic>> fuList = [
    {
      "bg": "fi.png",
      "isLock": true,
      "title": "身体倍棒",
    },
    {
      "bg": "fk.png",
      "isLock": true,
      "title": "顺利脱单",
    },
    {
      "bg": "fm.png",
      "isLock": true,
      "title": "锦鲤附体",
    },
    {
      "bg": "fo.png",
      "isLock": true,
      "title": "逢考必过",
    },
    {
      "bg": "fq.png",
      "isLock": true,
      "title": "人生巅峰",
    },
    {
      "bg": "fj.png",
      "isLock": true,
      "title": "身体倍棒1",
    },
    {
      "bg": "fl.png",
      "isLock": true,
      "title": "顺利脱单1",
    },
    {
      "bg": "fn.png",
      "isLock": true,
      "title": "锦鲤附体1",
    },
    {
      "bg": "fp.png",
      "isLock": true,
      "title": "逢考必过1",
    },
    {
      "bg": "fr.png",
      "isLock": true,
      "title": "人生巅峰1",
    },
  ];
}
