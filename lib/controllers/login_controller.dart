import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';

class LoginController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool secureText = true.obs;
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() async {
    super.onInit();

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
