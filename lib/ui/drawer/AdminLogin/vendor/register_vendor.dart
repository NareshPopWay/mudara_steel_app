// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/controllers/vendor_controller/register_vendor_conteoller.dart';
import 'package:path/path.dart';

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
                              "Register Vendor",
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
                                      return "Vendor name is Required";
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
                                    labelText: "Vendor name*",
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
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "password is Required";
                                    }else if (!controller.passwordRegex.hasMatch(e)) {
                                      // Return an error message if the input doesn't match the pattern
                                      return 'Password must be at least 8 characters long,\nwith at least one uppercase letter,\none lowercase letter, one number,\nand one special character.';
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
                                    labelText: "password*",
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
                                    labelText: "Driver name",
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
                                    labelText: "Driver Age",
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
                                    labelText: "Address(as per Aadhar)",
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
                                    labelText: "Email",
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
                                      return "Phone Number is Required";
                                    }else if(e.length < 10){
                                      // controller.noteFocus.requestFocus();
                                      return "phone number must be 10 digits";
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
                                    labelText: "Phone*",
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
                                      return "company name";
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
                                    labelText: "Company name*",
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
                                    labelText: "Drivers license number",
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
                                    labelText: "Vehicle insurance Number",
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
                                Text(
                                  "Upload Aadhar",
                                  style: Get.textTheme.bodyText1?.copyWith(
                                    fontSize: AppSpacings.s15,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeService.primaryColor,
                                  ),
                                ),
                                // Text(
                                //   "Word and Excel fiels are allowed",
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
                                    ) :  Text('Browse to choose file',
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
                                            "Upload",
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
                            controller.vendorRegistration();
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
                              "Submit",
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
