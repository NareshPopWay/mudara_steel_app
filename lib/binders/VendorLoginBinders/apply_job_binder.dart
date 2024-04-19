
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/apply_job_controller.dart';
import '../../common/themeService.dart';

class ApplyJobBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => ApplyJobController());

  }
}
