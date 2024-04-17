import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class VendorRegController extends GetxController {

  final key =  GlobalKey<FormState>();
  TextEditingController vendorName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverAge = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController drLicenseNo = TextEditingController();
  TextEditingController vehicleInNO = TextEditingController();
  TextEditingController tempNextFollowUp = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  RxString nextFollowUp = "".obs;
  RxBool secureText = true.obs;
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());

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


  Future<void> createJob()async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().registerVendor(
          data: {
              "FirstName": "",
              "MiddleName": "",
              "LastName": "",
              "VendorName": vendorName.text,
              "Email": "",
              "Phone": phone.text,
              "Fax": "",
              "Website": "",
              "Username": "",
              "Password": password.text,
              "CompanyName": companyName.text,
              "CompanyPhone": "",
              "Address": address.text,
              "Pincode": "",
              "CountryID": "",
              "StateID": "",
              "CityID": "",
              "BankName": "",
              "AccountNumber": "",
              "AccountHolderName": "",
              "AccountType": "",
              "AccountBranch": "",
              "TIN_No": "",
              "Description": "",
              "IFCSCode": "",
              "PAN_No": "",
              "GST_No": "",
              "Remark": "",
              "VendorType": "",
              "City": "",
              "VendorTypeID": "",
              "DriverName": driverName.text,
              "DriverAge": driverAge.text,
              "AadharCardUpload": "",
              "DriverLicenseNumber": drLicenseNo.text,
              "VehicleInsuranceNumber": vehicleInNO.text,
              "IsApproved":""
          },
          path: selectedFile.value!.path ?? "");
      if(successModel.msgType == 0){
        isLoading.value = false;
        // Get.offAndToNamed(Routes.jobList,arguments: "Job List");
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
