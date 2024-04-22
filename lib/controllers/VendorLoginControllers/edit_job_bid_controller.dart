
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_open_job_bid_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class EditJobBIdController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController cost = TextEditingController();
  TextEditingController remark = TextEditingController();
  Map data ={};
  RxString jobBidId = "".obs;
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
  MyOpenJobBidController myOpenJobBidController = Get.put(MyOpenJobBidController());

  RxString userTypeID = "".obs;

  @override
  void onInit() async {

    userTypeID.value =  GetStorage().read(Constants.userTypeID) ?? "";
    jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);

    // vendorJobBidList.value = await APIProvider().getVendorJobBide(jobId: 0);

    isLoading.value = true;
    if(Get.arguments != null && Get.arguments is Map){
      data = Get.arguments;
      cost.text = data['cost'];
      remark.text = data['remark'];
      jobBidId.value = data['jobBidId'].toString();
      for (int i = 0; i < jobNameList.length; i++) {
        if (jobNameList[i].value == data['jobId'].toString()) {
          selectedJobNameId.value = jobNameList[i].value.toString();
          selectedJobName.value = jobNameList[i].text.toString();
          break;
        }
      }

      // for (int i = 0; i < vendorJobBidList.length; i++) {
      //   if (vendorJobBidList[i].value == data['jobBidId'].toString()) {
      //     selectedVendorJobBidId.value = vendorJobBidList[i].value.toString();
      //     selectedVendorJobBid.value = vendorJobBidList[i].text.toString();
      //     break;
      //   }
      // }
      isLoading.value = false;
    }
    super.onInit();
  }

  Future<void> createJobAllocation()async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().applyJob(
        data: {
          "JobID" : selectedJobNameId.value,
          "JobBidID" : jobBidId.value,
          "Cost" : cost.text,
          "Remark" : remark.text,
        },
      );
      if(successModel.msgType == 0){
        isLoading.value = false;
        if (selectedJobNameId.value == "") {
          // myOpenJobBidController.jobBidPage = 0;
          // myOpenJobBidController.jobBidList.clear();
          // myOpenJobBidController.getJobBidList();
          Get.back();
          Ui.SuccessSnackBar(title:'Successful',message:'Job allocated successfully done');
        } else {
          Get.back();
          myOpenJobBidController.jobBidPage = 0;
          myOpenJobBidController.jobBidList.clear();
          myOpenJobBidController.getJobBidList();
          Ui.SuccessSnackBar(title:'Successful',message:'Job Updated Successfully done ');
        }
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
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

