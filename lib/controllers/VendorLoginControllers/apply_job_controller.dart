
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/Job_list_controller/open_job-list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/Job_list_controller/job_list_controller.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_open_job_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class ApplyJobController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController cost = TextEditingController();
  TextEditingController remark = TextEditingController();
  Map data ={};
  RxString jobId = "".obs;
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


  RxString userTypeID = "".obs;
  MyOpenJobController myOpenJobController = Get.put(MyOpenJobController());

  @override
  void onInit() async {

    userTypeID.value =  GetStorage().read(Constants.userTypeID) ?? "";
    jobNameList.value = await APIProvider().getJobNameList(userTypeID.value);


    if(Get.arguments != null && Get.arguments is String){
      jobId.value = Get.arguments;
      isLoading.value= true;
      for (int i = 0; i < jobNameList.length; i++) {
        if (jobNameList[i].value == jobId.value.toString()) {
          selectedJobNameId.value = jobNameList[i].value.toString();
          selectedJobName.value = jobNameList[i].text.toString();
          break;
        }
      }
      isLoading.value= false;
    }
    log('jobId = ${jobId.value}');
    super.onInit();
  }



  // getJobIdWiseData() async {
  //   isLoading.value = true;
  //   print("=============get getJobIdWiseData");
  //   clientIdWiseDataModel = await APIProvider().getClientIdWiseData(clientID: selectedClientId.value);
  //   phone.text = clientIdWiseDataModel!.phone!;
  //   name.text = clientIdWiseDataModel!.clientName!;
  //   address.text = clientIdWiseDataModel!.address!;
  //   isLoading.value = false;
  //   update();
  // }


  Future<void> applyJob(context)async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().applyJob(
        data: {
          "JobID" : selectedJobNameId.value,
          "VendorID" : "0",
          "Cost" : cost.text,
          "Remark" : remark.text,
        },
      );
      if(successModel.msgType == 0){
        isLoading.value = false;
        if (jobId.value == "") {
          Get.back();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'JobAppliedSuccessfullyDone')!);
        } else {
          Get.back();
          myOpenJobController.jobPage = 0;
          myOpenJobController.jobList.clear();
          myOpenJobController.getJob();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'JobAppliedSuccessfullyDone')!);
        }
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: getTranslated(context, 'SomethingWentWrong')!,message: getTranslated(context, 'JobNotApplied')!);
    }
  }

  // Future<void> getJobAllocationById({jobAllocationId}) async {
  //   isLoading.value = true;
  //
  //   JobAllocationModel jobAllocation = await APIProvider().getJobAllocationById(
  //       jobAllocationId:  jobAllocationId
  //   );
  //   if(jobAllocation != null){
  //     cost.text = jobAllocation.cost.toString();
  //     remark.text = jobAllocation.remark.toString();
  //     for (int i = 0; i < jobNameList.length; i++) {
  //       if (jobNameList[i].value == jobAllocation.jobId.toString()) {
  //         selectedJobNameId.value = jobNameList[i].value.toString();
  //         selectedJobName.value = jobNameList[i].text.toString();
  //         break;
  //       }
  //     }
  //     isLoading.value = false;
  //   }
  //   isLoading.value = false;
  //   return;
  // }
}

