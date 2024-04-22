
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_bid_model.dart';


class BidListController extends GetxController with GetTickerProviderStateMixin {

  RxString userTypeID = "".obs;

  RxInt currentTab = 0.obs;
  Rxn<TabController> tabController = Rxn<TabController>();
  RxString jobId = "".obs;

  @override
  void onInit() async {

    tabController.value = TabController(length: 2, vsync: this);
    userTypeID.value =  GetStorage().read(Constants.userTypeID) ?? "";
    log(userTypeID.value);

    if(Get.arguments != null && Get.arguments is String){
      jobId.value = Get.arguments;
    }


    super.onInit();
  }
}
