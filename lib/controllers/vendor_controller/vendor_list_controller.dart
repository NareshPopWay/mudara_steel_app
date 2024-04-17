
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';


class VendorListController extends GetxController {

  RxList vendorList = RxList();
  ScrollController leadScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();

  int vendorPage = 0;
  RxBool isSearching = RxBool(false);
  RxInt showCountVal = 10.obs;
  RxString shortByVal = "LeadDate".obs;
  RxString selectedShortByVal = "CreatedOn".obs;
  RxString descending = "desc".obs;
  RxString ascending = "asc".obs;

  RxBool isDescending = RxBool(false);

  RxBool isLoading = false.obs;
  RxBool isVendorListLoading = false.obs;
  TextEditingController toDate = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  @override
  void onInit() async {
    leadScrollController.addListener(vendorScrollListener);
    getVendor();
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

  RxList<FieldItemValueModel> vendorNameList = <FieldItemValueModel>[].obs;
  RxBool isVendorNameExpanded = false.obs;
  RxString selectedVendorName = "".obs;
  RxString selectedVendorNameId = "".obs;
  RxString tampSelectedVendorName = "".obs;
  RxString tampSelectedVendorNameId = "".obs;
  RxBool isVendorNameSearching = RxBool(false);
  Rx<TextEditingController> textVendorName = TextEditingController().obs;



  void vendorScrollListener() async {
    double maxScroll = leadScrollController.position.maxScrollExtent;
    double currentScroll = leadScrollController.position.pixels;
    double delta = Get.height / 3;
    if (maxScroll - currentScroll <= delta && !isVendorListLoading.value) {
      await getVendor(pagination: true);
    }
  }

  Future<void> getVendor({bool pagination = false}) async {
    isVendorListLoading.value = true;

    var leadResponse = await APIProvider().getVendorList(
      pageNumber: vendorPage,
      rowsOfPage: showCountVal,
      orderByName: selectedShortByVal,
      searchVal: searchTextEditController.text,
      fromDate: fromDate.value,
      toDate: toDate.value,
      sortDirection: isDescending.value == true ? ascending.value: descending.value,
      vendorId: selectedVendorNameId.value
    );
    if (leadResponse.isNotEmpty) {
      vendorPage++;
      vendorList.addAll(leadResponse);
    }
    isVendorListLoading.value = false;
    return;
  }

}
