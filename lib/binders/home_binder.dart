import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';
import 'package:mudara_steel_app/controllers/login_controller.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';

import '../controllers/web_home_controller.dart';


class HomeBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => WebHomeController());
    Get.lazyPut(() => AuthController());
  }
}
