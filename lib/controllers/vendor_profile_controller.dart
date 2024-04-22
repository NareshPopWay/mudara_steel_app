
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';
import 'package:mudara_steel_app/model/success_model.dart';
import 'package:mudara_steel_app/model/vendor_model.dart';


class VendorProfileController extends GetxController {

  final key =  GlobalKey<FormState>();
  final key1 =  GlobalKey<FormState>();
  final FocusNode noteFocus = FocusNode();
  TextEditingController vendorName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverAge = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController drLicenseNo = TextEditingController();
  TextEditingController vehicleInNO = TextEditingController();

  RxString vendorId = "".obs;


  RxBool isLoading = false.obs;



  RxString getFilePath = "".obs;
  Rx<File?> selectedFile = Rx(null);

  RootController rootController = Get.put(RootController());

  @override
  void onInit() async {
    getVendorProfileData();
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

  Future<void> updateVendor()async{
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: 'No Internet connection',message:'please connect with network');
      return;
    }
    try{
      isLoading.value = true;
      SuccessModel successModel =  await  APIProvider().updateVendor(
          data: {
            "VendorID" : vendorId.value,
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
        await APIProvider().getVendorProfileData();
        rootController.userName.value = GetStorage().read(Constants.userName) ?? "";
        Ui.SuccessSnackBar(title:'Successful',message:'Vendor profile successfully updated');
      }else if(successModel.msgType == 1){
        isLoading.value = false;
        Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
      }

    }catch(e){
      isLoading.value = false;
      log(e.toString());
      Ui.ErrorSnackBar(title: "Something went wrong ",message: "Vendor not Register");
    }
  }

  Future<void> getVendorProfileData() async {
    isLoading.value = true;

    VendorModel vendorModel = await APIProvider().getVendorProfileData();
    if(vendorModel != null){

      vendorId.value= vendorModel.vendorId.toString();
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

      isLoading.value = false;
    }
    isLoading.value = false;
    return;
  }
}
