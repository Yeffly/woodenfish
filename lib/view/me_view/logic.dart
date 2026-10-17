import 'package:get/get.dart';
import 'package:woodenfish/common/application.dart';
import 'package:woodenfish/common/constant.dart';

import 'state.dart';

class MeViewLogic extends GetxController {
  final MeViewState state = MeViewState();

  @override
  void onReady() {
    super.onReady();
    // =====离线精简版：注释应用内评价相关逻辑，不再引用isInAppReviewKey=====
    /*
    if (!Application.getStorage.hasData(Constant.isInAppReviewKey)) {
      Future.delayed(const Duration(milliseconds: 1000 * 10), () {
        // PubMethodUtils.getInAppReview();
        Application.getStorage.write(Constant.isInAppReviewKey, false);
      });
    }
    */
  }

  // ===== 离线版移除网络登录请求，删除getData函数 =====
  // getData() {
  //   var map = <String, dynamic>{};
  //   map['userName'] = "user";
  //   map['phoneNumber'] = "18627000332";
  //   map['password'] = "1026000";
  //   HttpUtils.instance.requestNetWorkAy(Method.post, "/user/login",
  //       baseUrl: "http://192.168.70.118:8085", data: map, isList: false);
  // }
}
