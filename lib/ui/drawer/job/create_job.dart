// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/controllers/job_controller/create_job_controller.dart';


class CreateJobScreen extends GetView<CreateJobController> {
  const CreateJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateJobController>(
        init: CreateJobController(),
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
                              "Create Job",
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
                                TextFormField(
                                  controller: controller.jobName,
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
                                      return "Job name is Required";
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
                                    labelText: "Job name*",
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
                                  controller: controller.fromLocation,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "From Location is Required";
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
                                    labelText: "From Location*",
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
                                  controller: controller.toLocation,
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
                                      return "To Location is Required";
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
                                    labelText: "To Location*",
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
                                  controller: controller.deliveryDate,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  cursorColor: ThemeService.primaryColor,
                                  readOnly: true,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  onTap: () async {
                                    // initialDate = textEditingController.text != "" ? DateTime.parse(textEditingController.text.toString()) : DateTime.now();
                                    DateTime? followUpPickedDate =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: controller.deliveryDate.text != "" ? DateTime.parse(controller.deliveryDate.text.toString()) : DateTime.now(),
                                      // initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                                      firstDate: DateTime(DateTime.now().year - 10),
                                      lastDate: DateTime(DateTime.now().year + 10),
                                    );
                                    if (followUpPickedDate != null) {
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                                      controller.deliveryDate.text = formattedDate;
                                      log(controller.deliveryDate.text);
                                      // controller.nextFollowUp.value = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                                    }
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
                                    labelText: "Delivery Date",
                                    suffixIcon:  Icon(Icons.calendar_month,color: ThemeService.primaryColor.withOpacity(0.7)),
                                    contentPadding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    labelStyle:  TextStyle(
                                      color: ThemeService.primaryColor.withOpacity(0.5),
                                      fontSize: AppSpacings.s18,
                                    ),
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintStyle:
                                    const TextStyle(color: ThemeService.white),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                TextFormField(
                                  controller: controller.weight,
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
                                  //     return "Weight is Required";
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
                                    labelText: "Weight",
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
                                searchDropDwonWidget(
                                  selectedValue: controller.tampSelectedJobType,
                                  selectedId: controller.tampSelectedJobTypeId,
                                  emptyTitle: "Job Type",
                                  list: controller.jobTypeList,
                                  isExpanded: controller.isJobTypeExpanded,
                                  isSearching: controller.isJobTypeSearching,
                                  textfield: controller.textJobType,
                                ),
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                searchDropDwonWidget(
                                  selectedValue: controller.tampSelectedJobStatus,
                                  selectedId: controller.tampSelectedJobStatusId,
                                  emptyTitle: "Job Status",
                                  list: controller.jobStatusList,
                                  isExpanded: controller.isJobStatusExpanded,
                                  isSearching: controller.isJobStatusSearching,
                                  textfield: controller.textJobStatus,
                                ),
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
                            FocusScope.of(context).unfocus();

                            // controller.addLead();
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


}
