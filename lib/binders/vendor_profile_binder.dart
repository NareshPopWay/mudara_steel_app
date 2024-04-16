
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/vendor_profile_controller.dart';
import '../common/themeService.dart';

class VendorProfileBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => VendorProfileController());

  }
}
