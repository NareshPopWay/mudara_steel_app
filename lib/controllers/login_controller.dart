import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class LoginController extends GetxController {

  RxString languageCode = "en".obs;

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool secureText = true.obs;
  RxBool isLoading = false.obs;
  AuthController authController = Get.put(AuthController());
  RxInt toggleValue = 0.obs;
  @override
  void onInit() async {
    super.onInit();

    toggleValue.value = GetStorage().read("selectedLanguage") ?? 0;

  }

  Future<void> login(context) async {
    bool isInternet = await Constants.isInternetAvail();
    if (!isInternet) {
      isLoading.value = false;
      Ui.worningSnackBar(title: getTranslated(context, 'NoInternetConnection')!,message:getTranslated(context, 'ConnectWithNetwork')!);
      return;
    }
    try {
      isLoading.value = true;
      bool login = await APIProvider().login(userName: userName.value.text, password:password.value.text,context);
      // log('${verifyOtpList!.patientList!.length}');
      // await Future.delayed(const Duration(milliseconds: 500));
      if (login == true) {
        isLoading.value = false;
        // GetStorage().write(Constants.userName, userName.value.text);
        // GetStorage().write(Constants.password, password.value.text);
        authController.isAlreadyLogin.value = true;
        // await APIProvider().getProfileData();
        Ui.SuccessSnackBar(title:getTranslated(context, 'Successful')!,message:getTranslated(context, 'LoginSuccessfullyDone')!);
        await Get.offAllNamed(Routes.home);
      }else{
        isLoading.value = false;
      }

    } catch (e) {
      isLoading.value = false;
      Ui.ErrorSnackBar(title:getTranslated(context, 'SomethingWentWrong')!,message:e.toString());
    }
  }

}
