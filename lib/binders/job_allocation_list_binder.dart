
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/vendor_controller/vendor_list_controller.dart';
import '../common/themeService.dart';

class JobAllocationListBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => JobAllocationListController());

  }
}
