// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/model/admin_block_model.dart';
import 'package:package_info_plus/package_info_plus.dart';


class RootController extends GetxController with GetTickerProviderStateMixin {
  RxString appVersion = "".obs;
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

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion.value = packageInfo.version;

  }

  void changeTab(int index){
    currentTab.value = index;
    update();
  }

  RxList<AdminBlockModel> adminBlocks = <AdminBlockModel>[
    AdminBlockModel(title: 'Register Vendor', imgUrl: 'assets/drawer_icon/add-user1.png'),
    AdminBlockModel(title: 'Vendor List', imgUrl: 'assets/drawer_icon/vendor_list.png'),
    AdminBlockModel(title: 'Create Job', imgUrl: 'assets/drawer_icon/create_job.png'),
    AdminBlockModel(title: 'Job List', imgUrl: 'assets/drawer_icon/job_list.png'),
    AdminBlockModel(title: 'Job Bid', imgUrl: 'assets/drawer_icon/bid_list.png'),
    AdminBlockModel(title: 'Allocated Job List', imgUrl: 'assets/drawer_icon/joballocation_list.png'),
  ].obs;

  RxList<AdminBlockModel> vendorBlock = <AdminBlockModel>[
    // AdminBlockModel(title: 'Apply Job', imgUrl: 'assets/drawer_icon/applyjob.png'),
    AdminBlockModel(title: 'All Job', imgUrl: 'assets/drawer_icon/job_list.png'),
    AdminBlockModel(title: 'My Bid', imgUrl: 'assets/drawer_icon/bid_list.png'),
    AdminBlockModel(title: 'My Allocated Job', imgUrl: 'assets/drawer_icon/joballocation_list.png'),
  ].obs;

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log('PageController Dispose');
    pageController.dispose();
  }

}
