import 'package:get/get.dart';
import 'package:woodenfish/view/introduction_view/view.dart';
import '../view/home_view/view.dart';
import '../view/main_view/view.dart';
import '../view/setting_view/view.dart';

import 'application.dart';
import 'c_key.dart';

class RouteConfig {
  ///主页面
  static const String home = "/";
  static const String main = "/main";
  static const String guide = "/guide";
  static const String setting = "/setting";
  static const String introduction = "/introduction";

  ///空白界面
  static const String notFound = "/notfound";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainViewPage()),
    GetPage(name: home, page: () => HomeViewPage()),
    GetPage(name: setting, page: () => SettingViewPage()),
    GetPage(name: introduction, page: () => IntroductionViewPage()),
  ];

  /// 判断启动入口（移除登录逻辑，纯离线）
  static String initRoute() {
    String page = RouteConfig.home;
    if (Application.getStorage.hasData(CKey.runOne)) {
      page = RouteConfig.home;
    } else {
      page = RouteConfig.guide;
    }
    return page;
  }
}
