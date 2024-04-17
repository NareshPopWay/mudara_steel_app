
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/model/field_item_value_model.dart';
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

  Map data ={};

  RxBool isLoading = false.obs;
  RxBool isSaveArchitech = false.obs;

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

  @override
  void onInit() async {

    jobStatusList.value = await APIProvider().getJobStatusList();
    jobTypeList.value = await APIProvider().getJobTypeList();

    if (Get.arguments != null && Get.arguments is Map) {
      data = Get.arguments;

      jobName.text = data["jobName"].toString();
      fromLocation.text = data["fromLocation"].toString();
      toLocation.text = data["toLocation"].toString();
      deliveryDate.text = data["deliveryDate"].toString();
      weight.text = data["weight"].toString();
    }
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
        Get.offAndToNamed(Routes.jobList,arguments: "Job List");
        // Constants.successSnackBar(title: "Lead Added Successfully");
        Ui.SuccessSnackBar(title:'Successful',message:'Lead Added Successfully');
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
