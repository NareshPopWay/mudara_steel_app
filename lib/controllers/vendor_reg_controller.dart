import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';
import 'package:mudara_steel_app/model/success_model.dart';

class VendorRegController extends GetxController {

  final FocusNode noteFocus = FocusNode();
  final key =  GlobalKey<FormState>();
  TextEditingController vendorName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverAge = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController drLicenseNo = TextEditingController();
  TextEditingController vehicleInNO = TextEditingController();

  final RegExp passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  RxBool secureText = true.obs;
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  RxString getFilePath = "".obs;
  Rx<File?> selectedFile = Rx(null);

  @override
  void onInit() async {
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


  Future<void> registerVendor(context)async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().registerVendor(
          data: {
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
          path: selectedFile.value != null ?selectedFile.value!.path : "");
      if(successModel.msgType == 0){
        isLoading.value = false;
        // Get.offAndToNamed(Routes.jobList,arguments: "Job List");
        Get.back();
        Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'VendorRegisterSuccessfullyUpdated')!);
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      log(e.toString());
      Ui.ErrorSnackBar(title: getTranslated(context, 'SomethingWentWrong')!,message: getTranslated(context, 'VendorNotRegister')!);
    }
  }

}
