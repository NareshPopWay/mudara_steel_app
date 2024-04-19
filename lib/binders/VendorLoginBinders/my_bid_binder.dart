
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_bid_controller.dart';

class MyBidBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => MyBidController());

  }
}
