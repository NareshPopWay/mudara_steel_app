
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/vendor_list_controller.dart';
import 'package:mudara_steel_app/model/job_model.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/model/vendor_model.dart';


class RegisterVendorController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController vendorName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverAge = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController drLicenseNo = TextEditingController();
  TextEditingController vehicleInNO = TextEditingController();
  TextEditingController tempNextFollowUp = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  RxString nextFollowUp = "".obs;


  RxBool isLoading = false.obs;

  RxString vendorId = "".obs;

  RxString getFilePath = "".obs;
  Rx<File?> selectedFile = Rx(null);

  VendorListController vendorListController = Get.put(VendorListController());

  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  @override
  void onInit() async {

    if (Get.arguments != null && Get.arguments is String) {
      vendorId.value = Get.arguments;
      isLoading.value= true;
      getVendorById(vendorId: vendorId.value);
    }
    log('vendorId = ${vendorId.value}');

    super.onInit();
  }


  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result?.files.single.path != null) {
      String path = result!.files.single.path!;
      File file = File(path);
      selectedFile.value = file;
    }
  }

  Future<void> checkVendorPhone(context)async{
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().checkVendorPhone(phone: phone.text);
      if(successModel.msgType == 0){
        isLoading.value = false;
        /// Api Call
         vendorRegistration(context);
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }
    }catch(e){
      isLoading.value = false;
      Ui.ErrorSnackBar(title: getTranslated(context, 'SomethingWentWrong')!);
    }
  }

  Future<void> vendorRegistration(context)async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().vendorRegistration(
          data: {
            if (vendorId.value != "") "VendorID" : vendorId.value,
            "VendorName": vendorName.text,
            "Email": email.text,
            "Phone": phone.text,
            "Password": password.text,
            "CompanyName": companyName.text,
            "Address": address.text,
            "DriverName": driverName.text,
            "DriverAge": driverAge.text,
            "DriverLicenseNumber": drLicenseNo.text,
            "VehicleInsuranceNumber": vehicleInNO.text,
            "IsApproved":"false"
          },
          path: selectedFile.value != null ? selectedFile.value!.path : File(getFilePath.value).path);
      if(successModel.msgType == 0){
        isLoading.value = false;
        if (vendorId.value == "") {
          // Get.offAndToNamed(Routes.jobList,arguments: "Job List");
          Get.back();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'VendorRegisterSuccessfullyUpdated')!);
        }else{
          Get.back();
          vendorListController.vendorPage = 0;
          vendorListController.vendorList.clear();
          vendorListController.getVendor();
          Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'VendorProfileSuccessfullyUpdated')!);
        }
        // Get.offAndToNamed(Routes.jobList,arguments: "Job List");

      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      log(e.toString());
      Ui.ErrorSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message:getTranslated(context, 'VendorNotRegister')!);
    }
  }

  Future<void> getVendorById({vendorId}) async {
    isLoading.value = true;

    VendorModel vendorModel = await APIProvider().getVendorById(
        vendorId:  vendorId
    );
    if(vendorModel != null){

       vendorName.text = vendorModel.vendorName!;
       password.text = vendorModel.password! ;
       driverName.text =vendorModel.driverName! ;
       driverAge.text = vendorModel.driverAge!;
       address.text =vendorModel.address! ;
       email.text= vendorModel.email!;
       phone.text= vendorModel.phone!;
       companyName.text= vendorModel.companyName!;
       drLicenseNo.text= vendorModel.driverLicenseNumber!;
       vehicleInNO.text= vendorModel.vehicleInsuranceNumber!;
       getFilePath.value = vendorModel.aadharCardUpload!;

      isLoading.value = false;
    }
    isLoading.value = false;
    return;
  }

}
