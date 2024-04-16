// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/constant.dart';


class RootController extends GetxController with GetTickerProviderStateMixin {
  RxInt currentTab = 0.obs;
  RxBool shearShow = false.obs;
  RxString userName = "".obs;
  RxString userTypeID = "".obs;
  RxString token="".obs;
  RxString roleId = "".obs;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();

  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() async {
    super.onInit();
    // posts.bindStream(FirebaseService().getPost());
    // treatments.bindStream(FirebaseService().getTreatments());
    // products.bindStream(FirebaseService().getProducts());
    userName.value = GetStorage().read(Constants.userName) ?? "";
    userTypeID.value = GetStorage().read(Constants.userTypeID) ?? "";
    currentTab.value =0;

  }

  void changeTab(int index){
    currentTab.value = index;
    update();
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log('PageController Dispose');
    pageController.dispose();
  }

}
