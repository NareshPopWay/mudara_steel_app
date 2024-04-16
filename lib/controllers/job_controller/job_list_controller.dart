
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_list_model.dart';


class JobListController extends GetxController {

  RxList<JobListModel> jobList = RxList();
  ScrollController leadScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();
  RxString appTitle = "".obs;
  RxBool isSearching = RxBool(false);
  int jobPage = 0;
  RxBool isLoading = false.obs;
  RxBool isJobListLoading = false.obs;
  RxString userTypeID = "".obs;

  TextEditingController tempToDate = TextEditingController();
  TextEditingController tempFromDate = TextEditingController();

  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  RxInt showCountVal = 10.obs;
  RxString shortByVal = "LeadDate".obs;
  RxString selectedShortByVal = "CreatedOn".obs;
  RxString descending = "desc".obs;
  RxString ascending = "asc".obs;

  RxBool isDescending = RxBool(false);

  @override
  void onInit() async {
    appTitle.value = Get.arguments;
    getJob();
    leadScrollController.addListener(jobScrollListener);
    userTypeID.value = GetStorage().read(Constants.userTypeID) ?? "";
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

  void jobScrollListener() async {
    double maxScroll = leadScrollController.position.maxScrollExtent;
    double currentScroll = leadScrollController.position.pixels;
    double delta = Get.height / 3;
    if (maxScroll - currentScroll <= delta && !isJobListLoading.value) {
      await getJob(pagination: true);
    }
  }

  Future<void> getJob({bool pagination = false}) async {
    isJobListLoading.value = true;

    var leadResponse = await APIProvider().getJobList(
        pageNumber: jobPage,
        rowsOfPage: showCountVal,
        orderByName: selectedShortByVal,
        searchVal: searchTextEditController.text,
        fromDate: fromDate.value,
        toDate: toDate.value,
        sortDirection: isDescending.value == true ? ascending.value: descending.value,
        jobId: selectedJobNameId.value,
        jobStatusId:selectedJobStatusId.value,
        jobType:selectedJobTypeId.value,
    );
    if (leadResponse.isNotEmpty) {
      jobPage++;
      jobList.addAll(leadResponse);
    }
    isJobListLoading.value = false;
    return;
  }



}
