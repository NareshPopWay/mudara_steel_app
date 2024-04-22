
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/apply_job_controller.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/edit_job_bid_controller.dart';
import '../../common/themeService.dart';

class EditJobBidBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => EditJobBIdController());

  }
}
