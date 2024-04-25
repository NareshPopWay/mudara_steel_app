
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_list_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';


class MyAllocatedJobController extends GetxController {

  RxList<JobAllocationListModel> jobAllocationList = RxList();
  ScrollController jobAllocationScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();
  RxBool isSearching = RxBool(false);
  RxBool isJobAllocationListLoading = false.obs;
  int jobAllocationPage = 0;
  RxBool isLoading = false.obs;
  RxString userTypeID = "".obs;

  TextEditingController tempToDate = TextEditingController();
  TextEditingController tempFromDate = TextEditingController();

  RxString fromDate = "".obs;
  RxString toDate = "".obs;

  var showCount = [10, 15, 20, 25, 50, 100];
  RxInt showCountVal = 10.obs;


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
    jobAllocationPage = 0;
    jobAllocationList.clear();
    getJobAllocation();
  }

  RxString shortByVal = "LeadDate".obs;
  RxString selectedShortByVal = "CreatedOn".obs;
  RxString descending = "desc".obs;
  RxString ascending = "asc".obs;
  RxBool isDeleteJobAllocation = false.obs;
  RxBool isDescending = RxBool(false);
  @override
  void onInit() async {
    super.onInit();
    userTypeID.value = await GetStorage().read(Constants.userTypeID) ?? "";
    jobAllocationScrollController.addListener(jobAllocationScrollListener);
    getJobAllocation();
    log(userTypeID.value);
    if(userTypeID.value == "1"){
      jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);
      vendorNameList.value = await APIProvider().getVendorName();
    }else{
      jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);
    }


  }

  void jobAllocationScrollListener() async {
    double maxScroll = jobAllocationScrollController.position.maxScrollExtent;
    double currentScroll = jobAllocationScrollController.position.pixels;
    double delta = Get.height / 3;
    if (maxScroll - currentScroll <= delta && !isJobAllocationListLoading.value) {
      await getJobAllocation(pagination: true);
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


  TextEditingController cost = TextEditingController();
  TextEditingController remark = TextEditingController();

  Future<void> getJobAllocation({bool pagination = false}) async {
    isJobAllocationListLoading.value = true;

    var leadResponse = await APIProvider().getJobAllocationList(
      userTypeID : userTypeID.value,
      pageNumber: jobAllocationPage,
      rowsOfPage: showCountVal,
      orderByName: selectedShortByVal,
      searchVal: searchTextEditController.text,
      fromDate: fromDate.value,
      toDate: toDate.value,
      sortDirection: isDescending.value == true ? ascending.value: descending.value,
      jobId: selectedJobNameId.value,
      vendorID:selectedVendorNameId.value,
    );
    if (leadResponse.isNotEmpty) {
      jobAllocationPage++;
      jobAllocationList.addAll(leadResponse);
    }
    isJobAllocationListLoading.value = false;
    return;
  }

  Future<void> deleteJobAllocation(context,{int? jobAllocationId})async{
    try{
      FocusScope.of(context).unfocus();
      isDeleteJobAllocation.value = true;
      SuccessModel successModel =  await  APIProvider().deleteJobAllocation(jobAllocationId: jobAllocationId);
      if(successModel.msgType == 0){
        isDeleteJobAllocation.value = false;
        Get.back();
        jobAllocationPage = 0;
        jobAllocationList.clear();
        getJobAllocation();
        Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'JobDeletedSuccessful')!);
      }else if(successModel.msgType == 1){
        isDeleteJobAllocation.value = false;
        Ui.ErrorSnackBar(title: getTranslated(context, 'SomethingWentWrong')!,message: successModel.message);
      }

    }catch(e){
      isDeleteJobAllocation.value = false;
      Ui.ErrorSnackBar(title: getTranslated(context, 'SomethingWentWrong')!,message:getTranslated(context, 'JobNotDelete')!);
    }
  }
}
