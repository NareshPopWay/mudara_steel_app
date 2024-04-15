
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/login_controller.dart';
import '../common/themeService.dart';
import '../controllers/auth_controller.dart';

class AuthBinder extends Bindings {
  @override
  void dependencies() {
    if (!(Get.isRegistered<AuthController>())) {
      Get.lazyPut(() => AuthController());
    }
    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginController());

  }
}
