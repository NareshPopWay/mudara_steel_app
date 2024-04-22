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
import 'package:mudara_steel_app/common/ui.dart';
import 'package:mudara_steel_app/common/widget/animated_toggle.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/create_job_allocation_controller.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/edit_job_bid_controller.dart';


class EditJobBidScreen extends GetView<EditJobBIdController> {
  const EditJobBidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditJobBIdController>(
        init: EditJobBIdController(),
        builder: (controller) {
          return Obx(() => Scaffold(
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
                              "Edit Job Bid",
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
                                searchDropDwonWidget(
                                  selectedValue: controller.selectedJobName,
                                  selectedId: controller.selectedJobNameId,
                                  emptyTitle: "Job Name",
                                  list: controller.jobNameList,
                                  isExpanded: controller.isJobNameExpanded,
                                  isSearching: controller.isJobNameSearching,
                                  textfield: controller.textJobName,
                                ),
                                SizedBox(
                                  height: AppSpacings.s15,
                                ),
                                // searchDropDwonWidget(
                                //   selectedValue: controller.selectedVendorJobBid,
                                //   selectedId: controller.selectedVendorJobBidId,
                                //   emptyTitle: "Vendor Job Bid",
                                //   list: controller.vendorJobBidList,
                                //   isExpanded: controller.isVendorJobBidExpanded,
                                //   isSearching: controller.isVendorJobBidSearching,
                                //   textfield: controller.textVendorJobBid,
                                // ),
                                // SizedBox(
                                //   height: AppSpacings.s20,
                                // ),
                                TextFormField(
                                  controller: controller.cost,
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
                                    labelText: "Cost",
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
                                  controller: controller.remark,
                                  enabled: true,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: ThemeService.primaryColor,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
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
                                    labelText: "Remark",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Bounce(
                      duration: const Duration(milliseconds: 150),
                      onPressed: (){
                        if(controller.selectedJobNameId.value == ""){
                          Ui.ErrorSnackBar(title: "Select Job Name",message: "Please Select Job Name");
                        }else{
                          FocusScope.of(context).unfocus();
                          controller.createJobAllocation();
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
