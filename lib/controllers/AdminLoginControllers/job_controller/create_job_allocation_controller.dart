
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_bid_controller/completed_job_bid_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_bid_controller/open_job_bid_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class CreateJobAllocationController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController cost = TextEditingController();
  TextEditingController remark = TextEditingController();
  Map data ={};
  RxString jobAllocationId = "".obs;
  RxBool isLoading = false.obs;

  RxBool isSelected = false.obs;
  RxInt toggleValue = 0.obs;

  RxList<FieldItemValueModel> jobNameList = <FieldItemValueModel>[].obs;
  RxBool isJobNameExpanded = false.obs;
  RxString selectedJobName = "".obs;
  RxString selectedJobNameId = "".obs;
  RxString tampSelectedJobName = "".obs;
  RxString tampSelectedJobNameId = "".obs;
  RxBool isJobNameSearching = RxBool(false);
  Rx<TextEditingController> textJobName = TextEditingController().obs;


  RxList<FieldItemValueModel> vendorJobBidList = <FieldItemValueModel>[].obs;
  RxBool isVendorJobBidExpanded = false.obs;
  RxString selectedVendorJobBid = "".obs;
  RxString selectedVendorJobBidId = "".obs;
  RxString tampSelectedVendorJobBid = "".obs;
  RxString tampSelectedVendorJobBidId = "".obs;
  RxBool isVendorJobBidSearching = RxBool(false);
  Rx<TextEditingController> textVendorJobBid = TextEditingController().obs;

  JobAllocationListController jobAllocationListController = Get.put(JobAllocationListController());
  OpenJobBidListController openJobBidListController = Get.put(OpenJobBidListController());
  CompletedJobBidListController completedJobBidListController = Get.put(CompletedJobBidListController());

  @override
  void onInit() async {

    jobNameList.value = await APIProvider().getJobName();
    vendorJobBidList.value = await APIProvider().getVendorJobBide(jobId: 0);
    isLoading.value = true;
    if(Get.arguments != null && Get.arguments is Map){
      data = Get.arguments;
      cost.text = data['cost'];
      remark.text = data['remark'];
      for (int i = 0; i < jobNameList.length; i++) {
        if (jobNameList[i].value == data['jobId'].toString()) {
          selectedJobNameId.value = jobNameList[i].value.toString();
          selectedJobName.value = jobNameList[i].text.toString();
          break;
        }
      }
      for (int i = 0; i < vendorJobBidList.length; i++) {
        if (vendorJobBidList[i].value == data['jobBidId'].toString()) {
          selectedVendorJobBidId.value = vendorJobBidList[i].value.toString();
          selectedVendorJobBid.value = vendorJobBidList[i].text.toString();
          break;
        }
      }
      isLoading.value = false;
    }else if(Get.arguments != null && Get.arguments is String){
      jobAllocationId.value = Get.arguments;
      isLoading.value= true;
      getJobAllocationById(jobAllocationId: jobAllocationId.value);
    }
    super.onInit();
  }

  Future<void> createJobAllocation(context)async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().createJobAllocation(
        data: {
          if (jobAllocationId.value != "") "JobAllocationID" : jobAllocationId.value ?? "",
          "JobID" : selectedJobNameId.value,
          "JobAllocationTypeID" : "0",
          "JobBidID" : selectedVendorJobBidId.value,
          "VendorID" : "0",
          "Cost" : cost.text,
          "Remark" : remark.text,
          // "CreatedOn" : DateFormat("yyyy/MM/dd").format(DateTime.now()),
          // "CreatedBY" : "1",
          // "CreatedUserTypeID" : "1"
        },
      );
      if(successModel.msgType == 0){
        isLoading.value = false;
        if (selectedJobNameId.value == "") {
          // jobAllocationListController.jobAllocationPage = 0;
          // jobAllocationListController.jobAllocationList.clear();
          // jobAllocationListController.getJobAllocation();
          // Get.offAndToNamed(Routes.jobAllocationList,arguments: "Job Allocation List");
          Get.back();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'JobAllocatedSuccessfullyDone')!);
        } else {
          Get.back();
          // jobAllocationListController.jobAllocationPage = 0;
          // jobAllocationListController.jobAllocationList.clear();
          // jobAllocationListController.getJobAllocation();
          openJobBidListController.jobBidPage = 0;
          openJobBidListController.jobBidList.clear();
          openJobBidListController.getJobBidList();

          completedJobBidListController.jobBidPage = 0;
          completedJobBidListController.jobBidList.clear();
          completedJobBidListController.getJobBidList();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'JobUpdatedSuccessfullyDone')!);
        }
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message:getTranslated(context, 'JobNotAllocated')!);
    }
  }

  Future<void> getJobAllocationById({jobAllocationId}) async {
    isLoading.value = true;

    JobAllocationModel jobAllocation = await APIProvider().getJobAllocationById(
        jobAllocationId:  jobAllocationId
    );
    if(jobAllocation != null){
      cost.text = jobAllocation.cost.toString();
      remark.text = jobAllocation.remark.toString();
      for (int i = 0; i < jobNameList.length; i++) {
        if (jobNameList[i].value == jobAllocation.jobId.toString()) {
          selectedJobNameId.value = jobNameList[i].value.toString();
          selectedJobName.value = jobNameList[i].text.toString();
          break;
        }
      }
      for (int i = 0; i < vendorJobBidList.length; i++) {
        if (vendorJobBidList[i].value == jobAllocation.jobBidId.toString()) {
          selectedVendorJobBidId.value = vendorJobBidList[i].value.toString();
          selectedVendorJobBid.value = vendorJobBidList[i].text.toString();
          break;
        }
      }
      isLoading.value = false;
    }
    isLoading.value = false;
    return;
  }
}

