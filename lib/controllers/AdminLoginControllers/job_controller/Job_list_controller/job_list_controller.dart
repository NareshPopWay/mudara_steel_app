
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_list_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';


class JobListController extends GetxController with GetTickerProviderStateMixin{

  RxString userTypeID = "".obs;

  RxInt currentTab = 0.obs;
  Rxn<TabController> tabController = Rxn<TabController>();


  @override
  void onInit() async {

    tabController.value = TabController(length: 2, vsync: this);
    userTypeID.value =  GetStorage().read(Constants.userTypeID) ?? "";
    log(userTypeID.value);
    super.onInit();
  }

}
