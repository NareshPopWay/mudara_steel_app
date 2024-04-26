
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/controllers/pdf_view_controller.dart';
import '../../common/themeService.dart';

class PdfViewScreen extends GetWidget<PdfViewController> {
  const PdfViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle( statusBarColor: ThemeService.primaryColor,),
          surfaceTintColor: ThemeService.primaryColor.withOpacity(0.1),
          backgroundColor: ThemeService.primaryColor.withOpacity(0.1),
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/logo1.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacings.s10, horizontal: AppSpacings.s10),
          child: Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: PDF(
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onPageChanged: (int? page, int? total) {

              },
            ).cachedFromUrl(controller.pdfUrl.value,
              placeholder: (progress) =>  const Center(child: CupertinoActivityIndicator()),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        ),
      ),
    );
  }
}
