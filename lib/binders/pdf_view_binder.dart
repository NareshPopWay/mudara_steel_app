import 'package:get/get.dart';
import 'package:mudara_steel_app/controllers/pdf_view_controller.dart';


class PdfViewBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PdfViewController());
  }
}
