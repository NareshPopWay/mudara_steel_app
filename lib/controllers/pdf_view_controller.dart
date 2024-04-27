// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';


class PdfViewController extends GetxController {


  RxBool isPdfLoading = false.obs;
  RxString pdfUrl = ''.obs;
  final Completer<PDFViewController> pdfViewController = Completer<PDFViewController>();
  final StreamController<String> pageCountController =  StreamController<String>();

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      pdfUrl.value = Get.arguments;
    }

  }
}
