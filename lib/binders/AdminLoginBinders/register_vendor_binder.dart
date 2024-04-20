
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/register_vendor_conteoller.dart';
import '../../common/themeService.dart';

class RegisterVendorBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => RegisterVendorController());

  }
}
