
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_allocated_job_controller.dart';

class MyAllocatedJobBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => MyAllocatedJobController());

  }
}
