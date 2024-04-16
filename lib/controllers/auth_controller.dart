// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/splash_screen.dart';
import 'package:mudara_steel_app/ui/home/home_screen.dart';
import 'package:mudara_steel_app/ui/login_screen.dart';
import '../common/appconstant.dart';


class AuthController extends GetxController  with GetTickerProviderStateMixin {

   Rx<Widget> displayWidget = Rx<Widget>(const SplashScreen());
   RxString userName = "".obs;

   RxBool visible = false.obs;
   RxBool isAlreadyLogin = RxBool(false);


   GlobalKey globalKeyOne = GlobalKey();
   GlobalKey globalKeyTwo = GlobalKey();
   GlobalKey globalKeyThree = GlobalKey();
   GlobalKey globalKeyFour = GlobalKey();
   GlobalKey globalKeyFive = GlobalKey();

  @override
  void onInit() async {
    super.onInit();

    var loginVal = await GetStorage().read(AppConstants.token);

    if (loginVal != null && loginVal != "") {
      isAlreadyLogin.value = true;
    }

    checkUserIsLoginOrNot();

  }


  checkUserIsLoginOrNot() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isAlreadyLogin.value == true) {
      displayWidget.value = const HomeScreen();
    }else{
      displayWidget.value = const LoginScreen();
    }
  }

}

