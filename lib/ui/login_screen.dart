// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/MultiLanguage/phoenix.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/common/widget/animated_toggle.dart';
import 'package:mudara_steel_app/controllers/login_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';
import 'package:particles_fly/particles_fly.dart';


class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: ThemeService.backgroundColor,
          body: OverlayLoaderWithAppIcon(
            isLoading: controller.isLoading.value,
            overlayBackgroundColor: ThemeService.grayScalecon,
            circularProgressColor: ThemeService.primaryColor,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                ParticlesFly(
                    height: Get.height,
                    width: Get.width,
                    connectDots: true,
                    speedOfParticles: 1,
                    particleColor: ThemeService.grayScale,
                    lineColor: ThemeService.grayScale,
                    numberOfParticles:50
                ),
                Positioned(
                  bottom: AppSpacings.s50,
                  right: AppSpacings.s20,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration:
                    BoxDecoration(
                      color: ThemeService.white,
                      borderRadius: BorderRadius.circular(AppSpacings.s10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                        getTranslated(context, 'selectLanguage')!,
                          style: Get.textTheme.bodyText1?.copyWith(
                            fontSize: AppSpacings.s20,
                            fontWeight: FontWeight.w600,
                            color: ThemeService.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AppSpacings.s8,
                        ),
                        AnimatedToggle(
                          width: Get.width * 0.5,
                          height: Get.width * 0.12,
                          values: ['हिंदी', 'English'],
                          onToggleCallback: (value) async{
                            controller.toggleValue.value = value;
                            log('${controller.toggleValue.value}');

                            controller.languageCode.value = controller.toggleValue.value == 1 ? "en" :"hi";
                            await GetStorage().write("selected", controller.languageCode.value);
                            await GetStorage().write("selectedLanguage", value);
                            await setLocale(controller.languageCode.value);
                            DemoGeofence.rebirth(context);
                          },
                          initialPosition: controller.toggleValue.value == 0 ? true : false ,
                          buttonColor: ThemeService.primaryColor,
                          backgroundColor:ThemeService.primaryColor.withOpacity(0.1),
                          textColor:ThemeService.white,
                        ),
                        SizedBox(
                          height: AppSpacings.s8,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // constraints: const BoxConstraints.expand(),
                  alignment: Alignment.center,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage('assets/app cover.jpg'),
                  //     fit: BoxFit.cover,
                  //   ),
                  //   // gradient: LinearGradient(
                  //   //   begin: Alignment.topCenter,
                  //   //   end: Alignment.bottomCenter,
                  //   //   colors: [ThemeService.primaryColor, ThemeService.primaryColor.withOpacity(0.4)],
                  //   // ),
                  // ),
                  child:  Padding(
                    padding: EdgeInsets.all(AppSpacings.s25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Image.asset(
                          //   'assets/splash_logo1.png',
                          //   fit: BoxFit.cover,
                          // ),
                          // SizedBox(height: AppSpacings.s35),
                          BlurryContainer(
                            blur: 2.5,
                            color: Colors.white,
                            padding: EdgeInsets.all(AppSpacings.s20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(height: AppSpacings.s45),
                                Container(
                                  height: AppSpacings.s100,
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Image.asset(
                                      getTranslated(context, 'LoginLogoPath')!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                // Text(
                                //   'Login Here',
                                //   style: Get.textTheme.headline1!.copyWith(
                                //     color: ThemeService.primaryColor,
                                //     fontSize: AppSpacings.s35,
                                //     fontWeight: FontWeight.w700,
                                //   ),
                                // ),
                                SizedBox(height: AppSpacings.s35),
                                // TextField(
                                //   controller: controller.userName,
                                //   enabled: true,
                                //   maxLines: 1,
                                //   keyboardType: TextInputType.text,
                                //   cursorColor: ThemeService.primaryColor,
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //   ),
                                //   decoration: InputDecoration(
                                //     filled: true,
                                //     prefixIcon: Container(
                                //       padding: const EdgeInsets.all(06.0),
                                //       child: SvgPicture.asset(
                                //         'assets/user.svg',
                                //         height: 20,
                                //         color: ThemeService.primaryColor,
                                //       ),
                                //     ),
                                //     fillColor: ThemeService.backgroundColor,
                                //     enabledBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(5)),
                                //     ),
                                //     focusedBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor,
                                //           width: 1.5),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(5)),
                                //     ),
                                //     disabledBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(5)),
                                //     ),
                                //     labelText: "Email / Phone Number",
                                //     contentPadding: const EdgeInsets.fromLTRB(
                                //         10, 10, 0, 0),
                                //     labelStyle: const TextStyle(
                                //         color: ThemeService.black),
                                //     hintStyle: const TextStyle(
                                //         color: ThemeService.primaryColor),
                                //   ),
                                // ),
                                TextFormField(
                                  controller: controller.userName,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(06.0),
                                      child: SvgPicture.asset(
                                        'assets/user.svg',
                                        height: 20,
                                        color: ThemeService.primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor
                                              .withOpacity(.5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor,
                                          width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor
                                              .withOpacity(.5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    errorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedErrorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    labelText: getTranslated(context, 'LoginEmail')!,
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    labelStyle: TextStyle(
                                      color: ThemeService.primaryColor.withOpacity(0.5),
                                      fontSize: AppSpacings.s18,

                                    ),
                                    errorStyle:TextStyle(
                                        fontSize: AppSpacings.s16,
                                        color: Colors.redAccent
                                    ),
                                    hintStyle:
                                    const TextStyle(color: ThemeService.white),
                                  ),
                                ),
                                SizedBox(height: AppSpacings.s25),
                                // TextField(
                                //   controller: controller.password,
                                //   enabled: true,
                                //   maxLines: 1,
                                //   obscureText: controller.secureText.value,
                                //   keyboardType: TextInputType.text,
                                //   cursorColor: ThemeService.primaryColor,
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //   ),
                                //   decoration: InputDecoration(
                                //     filled: true,
                                //     prefixIcon: Container(
                                //       padding: const EdgeInsets.all(12.0),
                                //       child: SvgPicture.asset(
                                //         'assets/password.svg',
                                //         height: 15,
                                //         color: ThemeService.primaryColor,
                                //       ),
                                //     ),
                                //     suffixIcon: IconButton(
                                //       onPressed: () {
                                //         controller.secureText.value =
                                //         !controller.secureText.value;
                                //       },
                                //       icon: Icon(controller.secureText.value
                                //           ? Icons.visibility_outlined
                                //           : Icons.visibility_off_outlined),
                                //       color: ThemeService.primaryColor,
                                //     ),
                                //     fillColor: ThemeService.primaryColor.withOpacity(0.1),
                                //     enabledBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10)),
                                //     ),
                                //     focusedBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor,
                                //           width: 1.5),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10)),
                                //     ),
                                //     disabledBorder: const OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //           color: ThemeService.primaryColor),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(10)),
                                //     ),
                                //     labelText: "Password",
                                //     labelStyle: const TextStyle(
                                //         color: ThemeService.black),
                                //     contentPadding: const EdgeInsets.fromLTRB(
                                //         10, 10, 0, 0),
                                //     hintStyle: const TextStyle(
                                //         color: ThemeService.primaryColor),
                                //   ),
                                // ),
                                TextFormField(
                                  controller: controller.password,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  obscureText: controller.secureText.value,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),

                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        'assets/password.svg',
                                        height: 15,
                                        color: ThemeService.primaryColor,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.secureText.value =
                                        !controller.secureText.value;
                                      },
                                      icon: Icon(controller.secureText.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined),
                                      color: ThemeService.primaryColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor
                                              .withOpacity(.5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor,
                                          width: 1.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeService.primaryColor
                                              .withOpacity(.5)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    errorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    focusedErrorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    labelText: getTranslated(context, 'LoginPassword')!,
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    labelStyle: TextStyle(
                                      color: ThemeService.primaryColor.withOpacity(0.5),
                                      fontSize: AppSpacings.s18,

                                    ),
                                    hintStyle:
                                    const TextStyle(color: ThemeService.white),
                                  ),
                                ),
                                SizedBox(height: AppSpacings.s70),
                                Bounce(
                                  duration: const Duration(milliseconds: 150),
                                  onPressed: () async{
                                    controller.isLoading.value = true;
                                    if (controller.userName.value.text == "" && controller.password.value.text == "") {
                                      controller.isLoading.value = false;
                                      Ui.ErrorSnackBar(title:"Flied is required",message: "username and password required");
                                    } else if (controller.userName.value.text == "") {
                                      controller.isLoading.value = false;
                                      Ui.ErrorSnackBar(title: "username is required",message: "username can't be empty");
                                    } else if (controller.password.value.text == "") {
                                      controller.isLoading.value = false;
                                      Ui.ErrorSnackBar(title: "password is required",message: "password can't be empty");
                                    } else {

                                      FocusScope.of(context).unfocus();
                                      controller.login(context);
                                      // Get.toNamed(Routes.home);
                                    }


                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ThemeService.primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(05),
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: ThemeService.primaryColor
                                        //         .withOpacity(0.5),
                                        //     spreadRadius: 1.5,
                                        //     blurRadius: 05,
                                        //     offset: const Offset(0, 2),
                                        //   ),
                                        // ]
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          AppSpacings.s15,
                                        ),
                                        child: Text(
                                          getTranslated(context, 'Login')!,
                                          style: Get.textTheme.headline1!
                                              .copyWith(
                                            color: ThemeService.white,
                                            fontSize: AppSpacings.s22,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppSpacings.s30),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     Expanded(
                                      child: Divider(
                                        color:ThemeService.primaryColor.withOpacity(0.5),
                                        thickness: 1,
                                        indent: 20,
                                      ),
                                    ),
                                    SizedBox(width: AppSpacings.s10),
                                    Text(
                                      getTranslated(context, 'OR')!,
                                      style: Get.textTheme.headline1!
                                          .copyWith(
                                        color: ThemeService.primaryColor,
                                        fontSize: AppSpacings.s15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: AppSpacings.s10),
                                     Expanded(
                                      child: Divider(
                                        color:ThemeService.primaryColor.withOpacity(0.5),
                                        thickness: 1,
                                        endIndent: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSpacings.s20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getTranslated(context, 'ForVendorRegistration')!,
                                      style: Get.textTheme.headline1!
                                          .copyWith(
                                        color: ThemeService.primaryColor.withOpacity(0.8),
                                        fontSize: AppSpacings.s18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: AppSpacings.s5),
                                    Bounce(
                                      duration: const Duration(milliseconds: 100),
                                      onPressed: (){
                                        Get.toNamed(Routes.vendorReg);
                                      },
                                      child: Text(
                                        getTranslated(context, 'ClickHere')!,
                                        style: Get.textTheme.headline1!
                                            .copyWith(
                                          color: Colors.blueAccent,
                                          fontSize: AppSpacings.s18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSpacings.s20),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           "Select Language",
                                //           style: Get.textTheme.bodyText1?.copyWith(
                                //             fontSize: AppSpacings.s20,
                                //             fontWeight: FontWeight.w600,
                                //             color: ThemeService.primaryColor,
                                //           ),
                                //         ),
                                //         SizedBox(
                                //           height: AppSpacings.s8,
                                //         ),
                                //         AnimatedToggle(
                                //           width: Get.width * 0.5,
                                //           height: Get.width * 0.12,
                                //           values: ['Hindi', 'English'],
                                //           onToggleCallback: (value) {
                                //             controller.toggleValue.value = value;
                                //             log('${controller.toggleValue.value}');
                                //           },
                                //           initialPosition: controller.toggleValue.value == 0 ? true : false ,
                                //           buttonColor: ThemeService.primaryColor,
                                //           backgroundColor:ThemeService.primaryColor.withOpacity(0.1),
                                //           textColor:ThemeService.white,
                                //         ),
                                //         SizedBox(
                                //           height: AppSpacings.s8,
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
