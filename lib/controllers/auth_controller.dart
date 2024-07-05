// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/app_notification/notification.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/splash_screen.dart';
import 'package:mudara_steel_app/ui/home/home_screen.dart';
import 'package:mudara_steel_app/ui/home/web_home_screen_1.dart';
import 'package:mudara_steel_app/ui/login_screen.dart';


class AuthController extends GetxController  with GetTickerProviderStateMixin {

   Rx<Widget> displayWidget = Rx<Widget>(const SplashScreen());
   RxString userName = "".obs;

   RxBool visible = false.obs;
   RxBool isAlreadyLogin = RxBool(false);

   String? firebaseToken;

  @override
  void onInit() async {
    super.onInit();

    var loginVal = await GetStorage().read(Constants.token);

    if (loginVal != null && loginVal != "") {
      isAlreadyLogin.value = true;
    }
    AppNotification().initiosPermission();
    AppNotification().notificationListener();


    firebaseToken = await FirebaseMessaging.instance.getToken();
    log('FirebaseToken : $firebaseToken');

    checkUserIsLoginOrNot();

  }


  checkUserIsLoginOrNot() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isAlreadyLogin.value == true) {
      displayWidget.value = const HomeScreen();
    }else{
      displayWidget.value = const WebHomeScreen();
      // displayWidget.value = const LoginScreen();
    }
  }

}

