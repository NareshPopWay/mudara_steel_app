
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_list_controller.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
import 'package:mudara_steel_app/model/job_allocation_model.dart';
import 'package:mudara_steel_app/model/job_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class CreateJobController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController jobName = TextEditingController();
  TextEditingController fromLocation = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController weightUnit = TextEditingController();
  TextEditingController remark = TextEditingController();
  TextEditingController toLocation = TextEditingController();
  TextEditingController deliveryDate = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  RxString nextFollowUp = "".obs;
  RxString jobId = "".obs;
  Map data ={};

  RxBool isLoading = false.obs;
  RxBool isSaveArchitech = false.obs;
  RxString userTypeID = "".obs;
  RxBool isSelected = false.obs;
  RxInt toggleValue = 0.obs;

  RxList<FieldItemValueModel> jobTypeList = <FieldItemValueModel>[].obs;
  RxBool isJobTypeExpanded = false.obs;
  RxString selectedJobType = "".obs;
  RxString selectedJobTypeId = "".obs;
  RxString tampSelectedJobType = "".obs;
  RxString tampSelectedJobTypeId = "".obs;
  RxBool isJobTypeSearching = RxBool(false);
  Rx<TextEditingController> textJobType = TextEditingController().obs;


  RxList<FieldItemValueModel> jobStatusList = <FieldItemValueModel>[].obs;
  RxBool isJobStatusExpanded = false.obs;
  RxString selectedJobStatus = "".obs;
  RxString selectedJobStatusId = "".obs;
  RxString tampSelectedJobStatus = "".obs;
  RxString tampSelectedJobStatusId = "".obs;
  RxBool isJobStatusSearching = RxBool(false);
  Rx<TextEditingController> textJobStatus = TextEditingController().obs;


  JobListController jobListController = Get.put(JobListController());

  @override
  void onInit() async {
    userTypeID.value = await GetStorage().read(Constants.userTypeID) ?? "";
    jobStatusList.value = await APIProvider().getJobStatusList(userTypeID.value);
    jobTypeList.value = await APIProvider().getJobTypeList(userTypeID.value);

    if (Get.arguments != null && Get.arguments is String) {
      jobId.value = Get.arguments;
      isLoading.value= true;
      getJobById(jobId: jobId.value);
    }
    log('jobId = ${jobId.value}');
    super.onInit();
  }



  Future<void> createJob()async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().createJob(
        data:
          {
            if (jobId.value != "") "JobID" : jobId.value,
            "CompanyID": "0",
            "JobName": jobName.text,
            "JobStatusID": selectedJobStatusId.value,
            "FromLocationID": "0",
            "FromLocation": fromLocation.text,
            "ToLocation": toLocation.text,
            "ToLocationID": "0",
            "DeliveryDate": deliveryDate.text,
            "JobTypeID": selectedJobTypeId.value,
            "IsTruck": toggleValue.value == 0 ? false : true ,
            "Weight": weight.text,
            "WeightUnit": weightUnit.text,
            "Column1": "Trailer",
            "Column2": "",
            "Remark": remark.text
        },
      );
      if(successModel.msgType == 0){
        isLoading.value = false;
        if (jobId.value == "") {
          // Get.offAndToNamed(Routes.jobList,arguments: "Job List");
          Get.back();
          Ui.SuccessSnackBar(title:'Successful',message:'Job Created successfully done');
        }else{
          Get.back();
          jobListController.jobPage = 0;
          jobListController.openJobList.clear();
          jobListController.getOpenJob();
          Ui.SuccessSnackBar(title:'Successful',message:'Job Updated Successfully done');
        }
        // Constants.successSnackBar(title: "Lead Added Successfully");
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
    }
  }

  Future<void> getJobById({jobId}) async {
    isLoading.value = true;

    JobModel jobModel = await APIProvider().getJobById(
        jobId:  jobId
    );
    if(jobModel != null){

      jobName.text = jobModel.jobName!;
      fromLocation.text =jobModel.fromLocation!;
      toLocation.text = jobModel.toLocation!;
      deliveryDate.text = DateFormat('yyyy-MM-dd').format(jobModel.deliveryDate!);
      weight.text = jobModel.weight.toString();
      weightUnit.text = jobModel.weightUnit!;
      remark.text = jobModel.remark!;
      toggleValue.value = jobModel.isTruck == true ?  1 : 0;

      for (int i = 0; i < jobTypeList.length; i++) {
        if (jobTypeList[i].value == jobModel.jobTypeId.toString()) {
          selectedJobTypeId.value = jobTypeList[i].value.toString();
          selectedJobType.value = jobTypeList[i].text.toString();
          break;
        }
      }
      for (int i = 0; i < jobStatusList.length; i++) {
        if (jobStatusList[i].value == jobModel.jobStatusId.toString()) {
          selectedJobStatusId.value = jobStatusList[i].value.toString();
          selectedJobStatus.value = jobStatusList[i].text.toString();
          break;
        }
      }

      isLoading.value = false;
    }
    isLoading.value = false;
    return;
  }

}
