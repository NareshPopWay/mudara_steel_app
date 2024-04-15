
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';


class VendorListController extends GetxController {

  RxList vendorList = RxList();

  RxBool isLoading = false.obs;
  RxBool isVendorListLoading = false.obs;
  TextEditingController toDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
  }


  RxList<FieldItemValueModel> jobNameList = <FieldItemValueModel>[].obs;
  RxBool isJobNameExpanded = false.obs;
  RxString selectedJobName = "".obs;
  RxString selectedJobNameId = "".obs;
  RxString tampSelectedJobName = "".obs;
  RxString tampSelectedJobNameId = "".obs;
  RxBool isJobNameSearching = RxBool(false);
  Rx<TextEditingController> textJobName = TextEditingController().obs;


}
