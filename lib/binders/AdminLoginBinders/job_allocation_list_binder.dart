
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/vendor_list_controller.dart';
import '../../common/themeService.dart';

class JobAllocationListBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => JobAllocationListController());

  }
}
