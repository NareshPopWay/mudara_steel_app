
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/vendor_reg_controller.dart';
import '../common/themeService.dart';

class VendorRegBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => VendorRegController());

  }
}
