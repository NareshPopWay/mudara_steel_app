
import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_bid_controller/bid_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/Job_list_controller/job_list_controller.dart';
import '../../common/themeService.dart';

class BidListBinder extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ThemeService());
    Get.lazyPut(() => BidListController());

  }
}
