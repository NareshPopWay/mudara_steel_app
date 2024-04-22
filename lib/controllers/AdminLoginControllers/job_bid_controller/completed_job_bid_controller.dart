

// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_bid_model.dart';


class CompletedJobBidListController extends GetxController {

  RxList<JobBidModel> jobBidList = RxList();
  RxBool isSearching = RxBool(false);
  int jobBidPage = 0;
  RxBool isLoading = false.obs;
  RxBool isJobBidListLoading = false.obs;
  ScrollController leadScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();
  TextEditingController tempToDate = TextEditingController();
  TextEditingController tempFromDate = TextEditingController();
  RxString userTypeID = "".obs;
  RxString fromDate = "".obs;
  RxString toDate = "".obs;


  var showCount = [10, 15, 20, 25, 50, 100];
  RxInt showCountVal = 10.obs;

  RxString shortByVal = "LeadDate".obs;
  RxString selectedShortByVal = "CreatedOn".obs;
  RxString descending = "desc".obs;
  RxString ascending = "asc".obs;

  RxBool isDescending = RxBool(false);

  List<DropdownMenuItem<Object?>> buildsShowCountItems(List _testList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return items;
  }

  onChangeShowCount(newValue) {
    print(newValue);
    showCountVal.value = newValue!;
    jobBidPage = 0;
    jobBidList.clear();
    getJobBidList();
  }

  @override
  void onInit() async {
    super.onInit();
    userTypeID.value = await GetStorage().read(Constants.userTypeID) ?? "";
    leadScrollController.addListener(jobScrollListener);
      getJobBidList();
    jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);
    jobStatusList.value = await APIProvider().getJobStatusList(userTypeID.value);
    jobTypeList.value = await APIProvider().getJobTypeList(userTypeID.value);
    vendorNameList.value = await APIProvider().getVendorName();
  }

  void jobScrollListener() async {
    double maxScroll = leadScrollController.position.maxScrollExtent;
    double currentScroll = leadScrollController.position.pixels;
    double delta = Get.height / 3;
    if (maxScroll - currentScroll <= delta && !isJobBidListLoading.value) {
      await getJobBidList(pagination: true);
    }
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

  RxList<FieldItemValueModel> jobStatusList = <FieldItemValueModel>[].obs;
  RxBool isJobStatusExpanded = false.obs;
  RxString selectedJobStatus = "".obs;
  RxString selectedJobStatusId = "".obs;
  RxString tampSelectedJobStatus = "".obs;
  RxString tampSelectedJobStatusId = "".obs;
  RxBool isJobStatusSearching = RxBool(false);
  Rx<TextEditingController> textJobStatus = TextEditingController().obs;

  RxList<FieldItemValueModel> jobTypeList = <FieldItemValueModel>[].obs;
  RxBool isJobTypeExpanded = false.obs;
  RxString selectedJobType = "".obs;
  RxString selectedJobTypeId = "".obs;
  RxString tampSelectedJobType = "".obs;
  RxString tampSelectedJobTypeId = "".obs;
  RxBool isJobTypeSearching = RxBool(false);
  Rx<TextEditingController> textJobType = TextEditingController().obs;

  Future<void> getJobBidList({bool pagination = false}) async {
    isJobBidListLoading.value = true;

    var leadResponse = await APIProvider().getJobBidList(
        userTypeID : userTypeID.value,
        pageNumber: jobBidPage,
        rowsOfPage: showCountVal,
        orderByName: selectedShortByVal,
        searchVal: searchTextEditController.text,
        fromDate: fromDate.value,
        toDate: toDate.value,
        sortDirection: isDescending.value == true ? ascending.value: descending.value,
        jobId: selectedJobNameId.value,
        jobStatusId:selectedJobStatusId.value,
        tempStatusID: "2",
        jobType:selectedJobTypeId.value,
        vendorID: selectedVendorNameId.value
    );
    if (leadResponse.isNotEmpty) {
      jobBidPage++;
      jobBidList.addAll(leadResponse);
    }
    isJobBidListLoading.value = false;
    return;
  }
}
