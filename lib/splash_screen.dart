import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeService.white,
      body:SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Image.asset(
            getTranslated(context, 'SplashScreenLogo')!,
            width: AppSpacings.s250,
          ),
        ),
      ),
    );
  }
}
