// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/register_vendor_conteoller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';
import 'package:path/path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class RegisterVendorScreen extends GetView<RegisterVendorController> {
  const RegisterVendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterVendorController>(
        init: RegisterVendorController(),
        builder: (controller) {
          return Obx(() => Scaffold(
            // backgroundColor: ThemeService.backgroundColor,
            // appBar: AppBar(
            //   backgroundColor: ThemeService.primaryColor.withOpacity(0.1),
            //   surfaceTintColor: ThemeService.primaryColor.withOpacity(0.1),
            //   foregroundColor: ThemeService.primaryColor.withOpacity(0.1),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Add Lead",
            //             style: Get.textTheme.headlineSmall!.copyWith(
            //               fontWeight: FontWeight.w700,
            //               color: ThemeService.primaryColor,
            //               fontSize: AppSpacings.s30,
            //             ),
            //           ),
            //           SizedBox(width: AppSpacings.s5),
            //           Image.asset(
            //             "assets/drawer_icon/addlead.png",
            //             height: AppSpacings.s30,
            //             color: ThemeService.primaryColor,
            //             alignment: Alignment.center,
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            //   leading:  Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         InkWell(
            //           onTap: () {
            //             Get.back();
            //           },
            //           child: Container(
            //             decoration: const BoxDecoration(
            //               color: ThemeService.primaryColor,
            //               shape: BoxShape.circle,
            //             ),
            //             child: Center(
            //               child: Icon(
            //                 Icons.chevron_left,
            //                 color: ThemeService.white,
            //                 size: AppSpacings.s50,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            body: OverlayLoaderWithAppIcon(
              isLoading: controller.isLoading.value,
              overlayBackgroundColor: ThemeService.grayScalecon,
              circularProgressColor: ThemeService.primaryColor,
              child: Container(
                height: Get.height,
                width: Get.width,
                color: ThemeService.primaryColor.withOpacity(0.1),
                // color: ThemeService.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: ThemeService.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: ThemeService.white,
                                  size: AppSpacings.s50,
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacings.s10),
                            Text(
                              getTranslated(context, 'Register Vendor')!,
                              style: Get.textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ThemeService.primaryColor,
                                fontSize: AppSpacings.s25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                        height: 10,
                        endIndent: 12,
                        indent: 12,
                        color: ThemeService.primaryColor,
                        thickness: 3),
                    Expanded(
                      child: Form(
                        key: controller.key,
                        child: Container(
                          padding: EdgeInsets.all(AppSpacings.s15),
                          margin: EdgeInsets.only(
                            left: AppSpacings.s10,
                            right: AppSpacings.s10,
                            top: AppSpacings.s10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ThemeService.white,
                            boxShadow:  [
                              BoxShadow(
                                  color: ThemeService.primaryColor.withOpacity(0.5),
                                  blurRadius: 9.5,
                                  blurStyle: BlurStyle.inner,
                                  // offset: const Offset(1.5,1.5),
                                  spreadRadius: 1.5
                              )
                            ],
                            border: Border.all(color: ThemeService.primaryColor.withOpacity(0.8)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                SizedBox(
                                  height: AppSpacings.s5,
                                ),
                                TextFormField(
                                  controller: controller.vendorName,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "${getTranslated(context, 'vNameValidator')!}";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText:"${getTranslated(context, 'Vendor name')!}*",
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.password,
                                  enabled: true,
                                  focusNode: controller.noteFocus,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      controller.noteFocus.requestFocus();
                                      return "${getTranslated(context, 'PasswordValidator')!}";
                                    }else if (e.length < 4) {
                                      controller.noteFocus.requestFocus();
                                      // Return an error message if the input doesn't match the pattern
                                      return "${getTranslated(context, 'PasswordValidator1')!}";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: "${getTranslated(context, 'Password')!}*",
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    labelStyle: TextStyle(
                                      color: ThemeService.primaryColor.withOpacity(0.5),
                                      fontSize: AppSpacings.s18,

                                    ),
                                    errorStyle:TextStyle(
                                        fontSize: AppSpacings.s16,
                                        height: 1.5,
                                        color: Colors.redAccent
                                    ),
                                    hintStyle:
                                    const TextStyle(color: ThemeService.white),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.driverName,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Driver name is Required";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: getTranslated(context, 'DriverName')!,
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.driverAge,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Driver Age is Required";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: getTranslated(context, 'DriverAge')!,
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.address,
                                  enabled: true,
                                  maxLines: 3,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Address is Required";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    focusedErrorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    errorBorder:const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.redAccent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    labelText: getTranslated(context, 'Address(as per Aadhar)')!,
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.email,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Email is Required";
                                  //   }else if(!controller.emailRegex.hasMatch(e)){
                                  //     return "Enter a valid email";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: getTranslated(context, 'VEmail')!,
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.phone,
                                  enabled: true,
                                  // focusNode: controller.noteFocus,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  cursorColor: ThemeService.primaryColor,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  onChanged: (value) {
                                    // if (controller.phoneNumber.value.text.length > 9) {
                                    //   FocusScope.of(context).unfocus();
                                    // }
                                  },
                                  validator:(e){
                                    if (e!.isEmpty) {
                                      // controller.noteFocus.requestFocus();
                                      return "${getTranslated(context, 'PhoneNoValidator')!}";
                                    }else if(e.length < 10){
                                      // controller.noteFocus.requestFocus();
                                      return "${getTranslated(context, 'PhoneNoValidator2')!}";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: "${getTranslated(context, 'Phone')!}*",
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.companyName,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "${getTranslated(context, 'CompanyValidator')!}";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: "${getTranslated(context, 'CompanyName')!}*",
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.drLicenseNo,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Drivers license number is Required";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText: "${getTranslated(context, 'DriversLicenseNumber')!}",
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.vehicleInNO,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  // validator: (e) {
                                  //   if (e!.isEmpty) {
                                  //     return "Vehicle insurance Number is Required";
                                  //   }
                                  //   return null;
                                  // },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeService.primaryColor.withOpacity(0.1),
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
                                    labelText:"${getTranslated(context, 'VehicleInsuranceNumber')!}",
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
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${getTranslated(context, 'UploadAadhar')!}",
                                      style: Get.textTheme.bodyText1?.copyWith(
                                        fontSize: AppSpacings.s18,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeService.primaryColor,
                                      ),
                                    ),
                                    if(controller.getFilePath.value != "")
                                    GestureDetector(
                                       onTap :(){
                                         var extension  = controller.getFilePath.value.toLowerCase().split(".").last;
                                         log(extension);

                                         if(extension == "pdf"){

                                           Get.toNamed(Routes.pdfView,
                                             arguments: controller.getFilePath.value != null ? APIProvider().imageUrl+controller.getFilePath.value :'http://116.72.8.100:2202' ,
                                           );

                                         }else{

                                           showGeneralDialog(
                                               transitionDuration: const Duration(milliseconds: 400),
                                               barrierDismissible: true,
                                               barrierLabel: '',
                                               pageBuilder: (ctx, a1, a2) {
                                                 return Container();
                                               },
                                               context: context,
                                               transitionBuilder: (ctx, a1, a2, child) {
                                                 var curve = Curves.easeInOut.transform(a1.value);
                                                 return Transform.scale(
                                                     scale: curve,
                                                     child: Opacity(
                                                         opacity: a1.value,
                                                         child: Dialog(
                                                           backgroundColor: Colors.transparent,
                                                           elevation: 0,
                                                           insetPadding: EdgeInsets.all(15),
                                                           shape: const RoundedRectangleBorder(
                                                             borderRadius: BorderRadius.all(
                                                               Radius.circular(10.0),
                                                             ),
                                                           ),
                                                           child: Center(
                                                             child: Column(
                                                               mainAxisSize: MainAxisSize.min,
                                                               children: [
                                                                 Align(
                                                                   alignment: const Alignment(1.10, -1.98),
                                                                   child: InkWell(
                                                                     onTap: () {
                                                                       Get.back();
                                                                     },
                                                                     child: CircleAvatar(
                                                                       backgroundColor: Colors.white,
                                                                       maxRadius: 17.0,
                                                                       child: Container(
                                                                         height: 30,
                                                                         decoration: const BoxDecoration(
                                                                           shape: BoxShape.circle,
                                                                           color: ThemeService.primaryColor,
                                                                         ),
                                                                         child: const Icon(
                                                                           Icons.close,
                                                                           color: Colors.white,
                                                                           size: 30,
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ),
                                                                 SizedBox(
                                                                   height: AppSpacings.s8,
                                                                 ),
                                                                 Center(
                                                                   child: Container(
                                                                     padding: EdgeInsets.only(
                                                                         left: AppSpacings.s10,
                                                                         right: AppSpacings.s10,
                                                                         top: AppSpacings.s10,
                                                                         bottom: AppSpacings.s10),
                                                                     decoration: BoxDecoration(
                                                                       color: Colors.white,
                                                                       borderRadius:
                                                                       BorderRadius.circular(14),
                                                                     ),
                                                                     child: InteractiveViewer(
                                                                       scaleFactor: 8.5,
                                                                       panEnabled: true,
                                                                       maxScale: 4,
                                                                       trackpadScrollCausesScale: true,
                                                                       child: CachedNetworkImage(
                                                                         imageUrl: controller.getFilePath.value != null ? APIProvider().imageUrl+controller.getFilePath.value :'http://116.72.8.100:2525' ,
                                                                         // height: AppSpacings.s130,
                                                                         // width: AppSpacings.s200,
                                                                         fit: BoxFit.contain,
                                                                         placeholder: (context, url) => SizedBox(
                                                                           // height: AppSpacings.s100,
                                                                           child: Shimmer.fromColors(
                                                                             baseColor: Colors.grey.shade300,
                                                                             highlightColor: Colors.grey.shade100,
                                                                             direction: ShimmerDirection.ltr,
                                                                             child: Container(
                                                                               color: Colors.white,
                                                                             ),
                                                                           ),
                                                                         ),
                                                                         errorWidget: (context, url, error) => Center(
                                                                           child: Text(
                                                                             getTranslated(context, 'ImageNotAvailable')!,
                                                                             textAlign: TextAlign.center,
                                                                             style: TextStyle(
                                                                               color: ThemeService.black,
                                                                               fontSize: AppSpacings.s30,
                                                                             ),
                                                                           ),
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 )
                                                               ],
                                                             ),
                                                           ),
                                                         )
                                                       // AlertDialog(
                                                     ));
                                               });
                                         }
                                       },
                                        child: Icon(Icons.info_outline,color: ThemeService.primaryColor,weight: AppSpacings.s25,))
                                  ],
                                ),
                                // Text(
                                //   getTranslated(context, 'PngJpgAndPDFFilesAreAllowed')!,
                                //   style: Get.textTheme.bodyText1?.copyWith(
                                //     fontSize: AppSpacings.s14,
                                //     color: ThemeService.primaryColor,
                                //   ),
                                // ),
                                SizedBox(height: AppSpacings.s10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ThemeService.primaryColor.withOpacity(0.1),
                                    border: Border.all(color: ThemeService.primaryColor
                                        .withOpacity(.1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: ListTile(
                                    horizontalTitleGap: 5.5,
                                    minLeadingWidth: 5,
                                    contentPadding: EdgeInsets.fromLTRB(AppSpacings.s10, 0, AppSpacings.s5, 0),
                                    dense: true,
                                    leading: const Icon(Icons.attach_file_rounded,),
                                    title: controller.getFilePath.value != "" && controller.selectedFile.value == null
                                        ? Text(controller.getFilePath.value) : controller.selectedFile.value != null ?
                                    Text(
                                      basename(controller.selectedFile.value!.path),
                                      style: Get.textTheme.bodyText1?.copyWith(
                                        fontSize: AppSpacings.s15,
                                        fontWeight: FontWeight.w600,
                                        color: ThemeService.primaryColor,
                                      ),
                                    ) :  Text('${getTranslated(context, 'BrowseToChooseFile')!}',
                                      style: Get.textTheme.bodyText1?.copyWith(
                                        fontSize: AppSpacings.s15,
                                        color: ThemeService.black,
                                      ),
                                    ),
                                    trailing: Bounce(
                                      duration: const Duration(milliseconds: 150),
                                      onPressed: (){
                                        controller.pickFile();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: ThemeService.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            getTranslated(context, 'Upload')!,
                                            style: Get.textTheme.bodyText1?.copyWith(
                                              fontSize: AppSpacings.s20,
                                              fontWeight: FontWeight.w600,
                                              color: ThemeService.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppSpacings.s10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 150),
                      onPressed: (){
                        if(controller.key.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.key.currentState!.save();

                          // if(controller.selectedFile.value == null){
                          //   Ui.ErrorSnackBar(title: "Upload Aadhar",message: "Please Upload Aadhar");
                          // } else {

                            FocusScope.of(context).unfocus();
                            controller.vendorRegistration(context);
                            // controller.checkVendorPhone();

                          // }
                        }else{
                          log("Not validate");
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(AppSpacings.s10, AppSpacings.s10, AppSpacings.s10, AppSpacings.s10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ThemeService.white,
                          boxShadow:  [
                            BoxShadow(
                                color: ThemeService.primaryColor.withOpacity(0.5),
                                blurRadius: 9.5,
                                blurStyle: BlurStyle.inner,
                                offset: const Offset(1.5,1.5),
                                spreadRadius: 1.5
                            )
                          ],
                          border: Border.all(color: ThemeService.primaryColor.withOpacity(0.8)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            AppSpacings.s12,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, 'Submit')!,
                              style: Get.textTheme.headline1!.copyWith(
                                color: ThemeService.primaryColor,
                                fontSize: AppSpacings.s25,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSpacings.s5,
                    ),

                  ],
                ),
              ),
            ),
          ));
        });
  }

  // addArchitech(context) {
  //   return Obx(() => SizedBox(
  //     height: Get.height * .40,
  //     child: Form(
  //       key: controller.key1,
  //       child: ListView(
  //         shrinkWrap: true,
  //         padding: EdgeInsets.only(
  //             left: AppSpacings.s20,
  //             top: AppSpacings.s30,
  //             right: AppSpacings.s20,
  //             bottom: AppSpacings.s15),
  //         children: [
  //           Text(
  //             'Add Architech',
  //             style: Get.textTheme.titleSmall!.copyWith(
  //               color: ThemeService.primaryColor,
  //               fontSize: AppSpacings.s25,
  //               fontFamily: 'OpenSans-Semibold',
  //             ),
  //           ),
  //           SizedBox(height: AppSpacings.s20),
  //           TextFormField(
  //             controller: controller.architechName,
  //             enabled: true,
  //             maxLines: 1,
  //             keyboardType: TextInputType.text,
  //             textInputAction: TextInputAction.next,
  //             cursorColor: ThemeService.primaryColor,
  //             style: const TextStyle(
  //               fontSize: 14,
  //             ),
  //             validator: (e) {
  //               if (e!.isEmpty) {
  //                 return "Name is Required";
  //               }
  //               return null;
  //             },
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: ThemeService.white,
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor
  //                         .withOpacity(.5)),
  //                 borderRadius: const BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor,
  //                     width: 1.5),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               disabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor
  //                         .withOpacity(.5)),
  //                 borderRadius: const BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               errorBorder:const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: Colors.redAccent),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               focusedErrorBorder:const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: Colors.redAccent),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               labelText: "Name*",
  //               contentPadding:
  //               const EdgeInsets.fromLTRB(10, 10, 0, 0),
  //               labelStyle: TextStyle(
  //                 color: ThemeService.primaryColor.withOpacity(0.5),
  //                 fontSize: AppSpacings.s18,
  //
  //               ),
  //               errorStyle:TextStyle(
  //                   fontSize: AppSpacings.s16,
  //                   color: Colors.redAccent
  //               ),
  //               hintStyle:
  //               const TextStyle(color: ThemeService.white),
  //             ),
  //           ),
  //
  //           SizedBox(
  //             height: AppSpacings.s15,
  //           ),
  //           TextFormField(
  //             controller: controller.architechTechPhone,
  //             enabled: true,
  //             maxLines: 1,
  //             keyboardType: TextInputType.number,
  //             textInputAction: TextInputAction.next,
  //             cursorColor: ThemeService.primaryColor,
  //             style: const TextStyle(
  //               fontSize: 14,
  //             ),
  //             validator: (e) {
  //               if(e!.isNotEmpty){
  //                 if(e.length < 10){
  //                   controller.noteFocus.requestFocus();
  //                   return "phone number must be 10 digits";
  //                 }
  //               }
  //               return null;
  //             },
  //             inputFormatters: <TextInputFormatter>[
  //               FilteringTextInputFormatter.digitsOnly,
  //               LengthLimitingTextInputFormatter(10),
  //             ],
  //             decoration: InputDecoration(
  //               filled: true,
  //               fillColor: ThemeService.white,
  //               enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor
  //                         .withOpacity(.5)),
  //                 borderRadius: const BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor,
  //                     width: 1.5),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               disabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: ThemeService.primaryColor
  //                         .withOpacity(.5)),
  //                 borderRadius: const BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               errorBorder:const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: Colors.redAccent),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               focusedErrorBorder:const OutlineInputBorder(
  //                 borderSide: BorderSide(
  //                     color: Colors.redAccent),
  //                 borderRadius: BorderRadius.all(
  //                     Radius.circular(10)),
  //               ),
  //               labelText: "Phone",
  //               contentPadding:
  //               const EdgeInsets.fromLTRB(10, 10, 0, 0),
  //               labelStyle: TextStyle(
  //                 color: ThemeService.primaryColor.withOpacity(0.5),
  //                 fontSize: AppSpacings.s18,
  //
  //               ),
  //               errorStyle:TextStyle(
  //                   fontSize: AppSpacings.s16,
  //                   color: Colors.redAccent
  //               ),
  //               hintStyle:
  //               const TextStyle(color: ThemeService.white),
  //             ),
  //           ),
  //           SizedBox(
  //             height: AppSpacings.s20,
  //           ),
  //           controller.isSaveArchitech.value
  //               ? CupertinoActivityIndicator(radius: AppSpacings.s20)
  //               : Bounce(
  //             duration: const Duration(milliseconds: 150),
  //             onPressed: () async {
  //               if(controller.key1.currentState!.validate()) {
  //                 FocusScope.of(context).unfocus();
  //                 controller.key1.currentState!.save();
  //
  //                 FocusScope.of(context).unfocus();
  //                 controller.saveArchitech(context);
  //
  //               }else{
  //                 log("Not validate");
  //               }
  //             },
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: ThemeService.primaryColor,
  //                 borderRadius: BorderRadius.circular(25),
  //                 // boxShadow: [
  //                 //   BoxShadow(
  //                 //     color: ThemeService.primaryColor
  //                 //         .withOpacity(0.5),
  //                 //     spreadRadius: 1.5,
  //                 //     blurRadius: 10,
  //                 //     offset: const Offset(0, 2),
  //                 //   ),
  //                 // ]
  //               ),
  //               child: Center(
  //                 child: Padding(
  //                   padding: EdgeInsets.all(
  //                     AppSpacings.s15,
  //                   ),
  //                   child: Text(
  //                     "Submit",
  //                     style: Get.textTheme.headline1!.copyWith(
  //                       color: ThemeService.white,
  //                       fontSize: AppSpacings.s25,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: AppSpacings.s10),
  //         ],
  //       ),
  //     ),
  //   ));
  // }

}
