
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_list_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';


class JobAllocationListController extends GetxController {

  RxList<JobAllocationListModel> jobAllocationList = RxList();
  ScrollController jobAllocationScrollController = ScrollController();
  TextEditingController searchTextEditController = TextEditingController();
  RxString appTitle = "".obs;
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
    appTitle.value = Get.arguments ?? "JobAllocation List ";
    getJobAllocation();
    jobNameList.value = await APIProvider().getJobName();
    vendorNameList.value = await APIProvider().getVendorName();
    vendorJobBidList.value = await APIProvider().getVendorJobBide(jobId: 0);
    jobName1List.value = await APIProvider().getJobName();
    jobAllocationScrollController.addListener(jobAllocationScrollListener);
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

  RxList<FieldItemValueModel> jobName1List = <FieldItemValueModel>[].obs;
  RxBool isJobName1Expanded = false.obs;
  RxString selectedJobName1 = "".obs;
  RxString selectedJobName1Id = "".obs;
  RxString tampSelectedJobName1 = "".obs;
  RxString tampSelectedJobName1Id = "".obs;
  RxBool isJobName1Searching = RxBool(false);
  Rx<TextEditingController> textJobName1 = TextEditingController().obs;

  RxList<FieldItemValueModel> vendorJobBidList = <FieldItemValueModel>[].obs;
  RxBool isVendorJobBidExpanded = false.obs;
  RxString selectedVendorJobBid = "".obs;
  RxString selectedVendorJobBidId = "".obs;
  RxString tampSelectedVendorJobBid = "".obs;
  RxString tampSelectedVendorJobBidId = "".obs;
  RxBool isVendorJobBidSearching = RxBool(false);
  Rx<TextEditingController> textVendorJobBid = TextEditingController().obs;


  Future<void> getJobAllocation({bool pagination = false}) async {
    isJobAllocationListLoading.value = true;

    var leadResponse = await APIProvider().getJobAllocationList(
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
        Ui.SuccessSnackBar(title:'Successful',message:'Job deleted successful');
      }else if(successModel.msgType == 1){
        isDeleteJobAllocation.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isDeleteJobAllocation.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
    }
  }
}
