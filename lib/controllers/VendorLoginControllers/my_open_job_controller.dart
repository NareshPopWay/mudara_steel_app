
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_list_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';


class MyOpenJobController extends GetxController {

  RxList<JobListModel> jobList = RxList();
  ScrollController leadScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();
  RxBool isSearching = RxBool(false);
  int jobPage = 0;
  RxBool isLoading = false.obs;
  RxBool isJobListLoading = false.obs;
  RxString userTypeID = "".obs;

  TextEditingController tempToDate = TextEditingController();
  TextEditingController tempFromDate = TextEditingController();

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
    jobPage = 0;
    jobList.clear();
    getJob();
  }

  @override
  void onInit() async {

    userTypeID.value =  GetStorage().read(Constants.userTypeID) ?? "";
    log(userTypeID.value);
    leadScrollController.addListener(jobScrollListener);
    getJob();
    jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);
    jobTypeList.value = await APIProvider().getJobTypeList(userTypeID.value);

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
      userTypeID:userTypeID.value,
      pageNumber: jobPage,
      rowsOfPage: showCountVal,
      orderByName: selectedShortByVal,
      searchVal: searchTextEditController.text,
      fromDate: fromDate.value,
      toDate: toDate.value,
      sortDirection: isDescending.value == true ? ascending.value: descending.value,
      jobId: selectedJobNameId.value,
      jobStatusId:"1",
      jobType:selectedJobTypeId.value,
    );
    if (leadResponse.isNotEmpty) {
      jobPage++;
      jobList.addAll(leadResponse);
    }
    isJobListLoading.value = false;
    return;
  }


  Future<void> deleteJob(context,{int? jobId})async{
    try{
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().deleteJob(jobId: jobId);
      if(successModel.msgType == 0){
        isLoading.value = false;
        Get.back();
        jobPage = 0;
        jobList.clear();
        getJob();
        Ui.SuccessSnackBar(title:'Successful',message:'Job deleted successful');
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
    }
  }


  Future<void> saveBide(context,{int? jobId,double? cost})async{
    try{
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().saveBide(jobId: jobId,cost: cost);
      if(successModel.msgType == 0){
        isLoading.value = false;
        jobPage = 0;
        jobList.clear();
        getJob();
        Ui.SuccessSnackBar(title:'Successful',message:'Job successfully applied');
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
    }
  }
}
