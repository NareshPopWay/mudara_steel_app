import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';

class VendorRegController extends GetxController {

  final key =  GlobalKey<FormState>();
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


// Future<void> login() async {
//   bool isInternet = await Constants.isInternetAvail();
//   if (!isInternet) {
//     isLoading.value = false;
//     Ui.worningSnackBar(title: 'No Internet connection',message:'Connect with network');
//     return;
//   }
//   try {
//     isLoading.value = true;
//     bool login = await APIProvider().login(userName: userName.value.text, password:password.value.text);
//     // log('${verifyOtpList!.patientList!.length}');
//     await Future.delayed(const Duration(milliseconds: 500));
//     if (login == true) {
//       isLoading.value = false;
//       // GetStorage().write(Constants.userName, userName.value.text);
//       // GetStorage().write(Constants.password, password.value.text);
//       authController.isAlreadyLogin.value = true;
//       // await APIProvider().getProfileData();
//       Ui.SuccessSnackBar(title:'Successful',message:'Login successfully done');
//       await Get.offAllNamed(Routes.home);
//     }else{
//       isLoading.value = false;
//     }
//
//   } catch (e) {
//     isLoading.value = false;
//     Ui.ErrorSnackBar(title:'Something went wrong!',message:e.toString());
//   }
// }

}
