
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/vendor_list_controller.dart';
import '../../common/themeService.dart';

class VendorListBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => VendorListController());

  }
}
