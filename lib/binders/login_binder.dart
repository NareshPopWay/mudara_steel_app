
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/login_controller.dart';
import '../common/themeService.dart';

class LoginBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => LoginController());

  }
}
