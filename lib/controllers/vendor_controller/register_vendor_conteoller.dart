
// ignore_for_file: iterable_contains_unrelated_type, unrelated_type_equality_checks, list_remove_unrelated_type
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


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
  TextEditingController drLicenseNo = TextEditingController();
  TextEditingController vehicleInNO = TextEditingController();
  TextEditingController tempNextFollowUp = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  RxString nextFollowUp = "".obs;


  RxBool isLoading = false.obs;



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
  // Future<void> addLead()async{
  //   bool isInternet = await Constants.isInternetAvail();
  //   if (!isInternet) {
  //     isLoading.value = false;
  //     Constants.ErrorSnackBar(title:"No Internet connection",message: "Please turn on internet connection");
  //     return;
  //   }
  //   try{
  //     isLoading.value = true;
  //     SuccessModel successModel =  await  APIProvider().addLead(
  //       data: {
  //         "Phone": phone.text,
  //         "ClientId": selectedClientId.value,
  //         "ClientName": name.text,
  //         "Address": address.text,
  //         "StateID": selectedStateId.value,
  //         "CityID": selectedCityId.value,
  //         "LeadSourceID": selectedLeadSourceId.value,
  //         "RefBy": referenceBy.text,
  //         "RefPhone": referencePhone.text,
  //         "ArchitechEmpID": selectedArchitectNameId.value,
  //         "EmployeeID": selectedSalesPersonId.value,
  //         "Remark": remark.text,
  //         "LeadStatusID": selectedStatusId.value,
  //         "NextFollowupDate": tempNextFollowUp.text,
  //         "objLeadDetail": List.from(selectedProductList.map((e) => e.toJson()).toList()),
  //       },
  //     );
  //     if(successModel.msgType == 0){
  //       isLoading.value = false;
  //       Get.offAndToNamed(Routes.leadList);
  //       // Constants.successSnackBar(title: "Lead Added Successfully");
  //       Ui.SuccessSnackBar(title:'Successful',message:'Lead Added Successfully');
  //     }else if(successModel.msgType == 1){
  //       isLoading.value = false;
  //       Ui.ErrorSnackBar(title: "Something went wrong ",message: successModel.message);
  //     }
  //
  //   }catch(e){
  //     isLoading.value = false;
  //     Ui.ErrorSnackBar(title: "Something went wrong ",message: "Lead not added");
  //   }
  // }


}
