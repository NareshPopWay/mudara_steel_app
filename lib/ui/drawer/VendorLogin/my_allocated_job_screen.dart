// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, must_be_immutable
import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/dropdown_below.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/common/widget/empty_widget.dart';
import 'package:mudara_steel_app/common/widget/lead_card_widget.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_allocated_job_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_bid_controller/bid_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/job_controller/Job_list_controller/job_list_controller.dart';
import 'package:mudara_steel_app/controllers/AdminLoginControllers/vendor_controller/vendor_list_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class MyAllocatedJobScreen extends GetView<MyAllocatedJobController> {
  MyAllocatedJobScreen({Key? key}) : super(key: key);

  MyAllocatedJobController controller = Get.put(MyAllocatedJobController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: OverlayLoaderWithAppIcon(
        isLoading: controller.isLoading.value,
        overlayBackgroundColor: ThemeService.grayScalecon,
        circularProgressColor: ThemeService.primaryColor,
        child: Container(
          height: Get.height,
          width: Get.width,
          // color: ThemeService.primaryColor.withOpacity(0.1),
          color: ThemeService.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            getTranslated(context, 'AllocatedJob')!,
                            style: Get.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ThemeService.primaryColor,
                              fontSize: AppSpacings.s25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 35,
                            child: Row(
                              children: [
                                Text(
                                  getTranslated(context, 'Show')!,
                                  style: Get.textTheme.displaySmall!.copyWith(fontSize: AppSpacings.s18),
                                ),
                                SizedBox(
                                  width: AppSpacings.s5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(AppSpacings.s10, 0, AppSpacings.s10, 0),
                                  decoration: BoxDecoration(color: ThemeService.primaryColor, borderRadius: BorderRadius.circular(10)),
                                  child:DropdownBelow(
                                      itemWidth: 80,
                                      itemTextstyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black,fontFamily:'Poppins-Medium'),
                                      boxTextstyle: Get.textTheme.displaySmall!.copyWith(fontSize: AppSpacings.s16,color: Colors.white),
                                      boxHeight: 50,
                                      icon: const Icon(Icons.keyboard_arrow_down,color: ThemeService.white),
                                      boxWidth: 50,
                                      hint: Text('${controller.showCountVal.value}'),
                                      value: controller.showCountVal.value,
                                      items: controller.buildsShowCountItems(controller.showCount),
                                      onChanged: controller.onChangeShowCount
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSpacings.s5),
                          GestureDetector(
                            onTap: ()async{
                              await showModalBottomSheet(
                                  context: context,
                                  backgroundColor: ThemeService.white,
                                  elevation: 5.5,
                                  useSafeArea: true,
                                  constraints: const BoxConstraints(maxHeight:650),
                                  isScrollControlled:true,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                                  builder: (context){
                                    return Filter(context);
                                  }
                              );
                            },
                            child: Center(
                              child: Container(
                                decoration:  BoxDecoration(
                                    color: ThemeService.primaryColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(
                                    "assets/filter.png",
                                    height: AppSpacings.s30,
                                    color: ThemeService.white,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
              SizedBox(
                height: AppSpacings.s5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(AppSpacings.s30, AppSpacings.s20,
                          AppSpacings.s10, AppSpacings.s20),
                      child: Center(
                        child: CupertinoSearchTextField(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ThemeService.white,
                              boxShadow:  [
                                BoxShadow(
                                  color: ThemeService.disable.withOpacity(0.8),
                                  blurRadius: 08.0,
                                )
                              ]
                            // border: Border.all(color: ThemeService.primaryColor),
                          ),
                          // backgroundColor: ThemeService.grayScale.withOpacity(.7),
                          itemColor: ThemeService.black,
                          placeholder: getTranslated(context, 'Search')!,
                          controller: controller.searchTextEditController,
                          placeholderStyle: TextStyle(
                              fontSize: AppSpacings.s18,
                              color: Get.theme.disabledColor),
                          onSuffixTap: () {
                            // controller.isMemberSearching.value = false;
                            // controller.memberSearchResult.clear();
                            controller.searchTextEditController.clear();
                            controller.jobAllocationPage = 0;
                            controller.jobAllocationList.clear();
                            controller.getJobAllocation();
                            controller.searchTextEditController.clear();
                            FocusScope.of(context).unfocus();
                          },
                          suffixIcon: Icon(
                            Icons.cancel,
                            size: AppSpacings.s30,
                            color: ThemeService.primaryColor,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: AppSpacings.s30,
                              color: ThemeService.primaryColor,
                            ),
                          ),
                          onChanged: (value) {
                            if(value.length >= 3){
                              EasyDebounce.debounce('lead', const Duration(milliseconds: 700), () {
                                controller.jobAllocationPage = 0;
                                controller.jobAllocationList.clear();
                                controller.getJobAllocation();
                              });
                            }else if(value.isEmpty){
                              EasyDebounce.debounce('lead', const Duration(milliseconds: 700), () {
                                controller.jobAllocationPage = 0;
                                controller.jobAllocationList.clear();
                                controller.getJobAllocation();
                              });
                            }

                          },
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      controller.isDescending.value = !controller.isDescending.value;
                      // controller.isDescending.value == true ? controller.descending.value : controller.ascending.value;
                      controller.jobAllocationPage = 0;
                      controller.jobAllocationList.clear();
                      controller.getJobAllocation();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacings.s8, vertical: AppSpacings.s12),
                      margin: EdgeInsets.fromLTRB(0, 0,
                          AppSpacings.s25, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: ThemeService.white,
                        boxShadow:  [
                          BoxShadow(
                            color: ThemeService.disable.withOpacity(0.8),
                            blurRadius: 08.0,
                          ),],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            children: [
                              const RotatedBox(
                                quarterTurns: 1,
                                child: Icon(Icons.compare_arrows,
                                  color: ThemeService.primaryColor,
                                ),
                              ),
                              Text(controller.isDescending.value ? 'Asc': 'Desc',
                                style: Get.textTheme.displaySmall!.copyWith(fontSize: AppSpacings.s20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                    controller: controller.jobAllocationScrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(0,0, 0, AppSpacings.s55),
                    primary: false,
                    physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                    children: [
                      if (controller.jobAllocationList.isEmpty && !controller.isJobAllocationListLoading.value)
                        Padding(
                          padding:  EdgeInsets.only(top: AppSpacings.s50),
                          child: const EmptyDataWidget(),
                        )
                      else
                        ListView.builder(
                            padding: EdgeInsets.only(
                              left: AppSpacings.s20,
                              right: AppSpacings.s20,
                              bottom: AppSpacings.s20,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.jobAllocationList.length,
                            itemBuilder:(context,index){

                              return  Container(
                                margin: EdgeInsets.fromLTRB(0, AppSpacings.s20, 0, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ThemeService.white,
                                    boxShadow:  [
                                      BoxShadow(
                                          color: ThemeService.primaryColor.withOpacity(0.3),
                                          blurRadius: 7.5,
                                          blurStyle: BlurStyle.normal,
                                          spreadRadius: 1.0
                                      )
                                    ],
                                    border: const BorderDirectional(start: BorderSide(color: ThemeService.primaryColor,width:4))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: AppSpacings.s5,
                                    ),
                                    headerRow(
                                      title1: controller.jobAllocationList[index].createdOn != null
                                          ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.jobAllocationList[index].createdOn.toString()))
                                          : "-",
                                      icon1: Icon(Icons.calendar_month, size: AppSpacings.s25),
                                    ),
                                    // Container(
                                    //   height: AppSpacings.s50,
                                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           Icon(Icons.calendar_month, size: AppSpacings.s25),
                                    //           Text(
                                    //             "15/04/24",
                                    //             overflow: TextOverflow.ellipsis,
                                    //             style: Get.textTheme.displayMedium!.copyWith(
                                    //               color: Colors.black,
                                    //               fontWeight: FontWeight.w700,
                                    //               fontSize: AppSpacings.s20,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       Row(
                                    //         children: [
                                    //           Text(
                                    //             "JOB",
                                    //             overflow: TextOverflow.ellipsis,
                                    //             style: Get.textTheme.displayMedium!.copyWith(
                                    //               color: Colors.black,
                                    //               fontWeight: FontWeight.w700,
                                    //               fontSize: AppSpacings.s20,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const Divider(
                                        height: 5,
                                        endIndent: 10,
                                        indent: 10,
                                        color: ThemeService.primaryColor,
                                        thickness: 2),
                                    dataRow(
                                      title1: getTranslated(context, 'JobName')!,
                                      value1: controller.jobAllocationList[index].jobName ?? "-",
                                      title2: getTranslated(context, 'VendorName')!,
                                      value2:  controller.jobAllocationList[index].vendorName ?? "-",
                                    ),
                                    Divider(
                                        height: 2,
                                        endIndent: 10,
                                        indent: 10,
                                        color: ThemeService.primaryColor.withOpacity(0.2),
                                        thickness: 1),
                                    dataRow(
                                      title1: getTranslated(context, 'Cost')!,
                                      value1: controller.jobAllocationList[index].cost.toString() ?? "-",
                                      title2: getTranslated(context, 'Remark')!,
                                      value2: controller.jobAllocationList[index].remark ?? "-",
                                    ),
                                    if(controller.userTypeID.value == "1")
                                      Divider(
                                          height: 2,
                                          endIndent: 10,
                                          indent: 10,
                                          color: ThemeService.primaryColor.withOpacity(0.2),
                                          thickness: 1),
                                    SizedBox(height: AppSpacings.s5),
                                  ],
                                ),
                              );
                            }
                        ),
                      if (controller.isJobAllocationListLoading.value == true)  CupertinoActivityIndicator(radius: AppSpacings.s20,)
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Filter(context) {

    controller.tampSelectedJobName.value = controller.selectedJobName.value;
    controller.tampSelectedJobNameId.value = controller.selectedJobNameId.value;

    controller.tampSelectedVendorName.value = controller.selectedVendorName.value;
    controller.tampSelectedVendorNameId.value = controller.selectedVendorNameId.value;

    controller.tempFromDate.text = controller.fromDate.value;
    controller.tempToDate.text = controller.toDate.value;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            color: ThemeService.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppSpacings.s5),
            Container(
              width: Get.width*0.15,
              height: Get.height*0.008,
              decoration: BoxDecoration(
                  color: ThemeService.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: ThemeService.primaryColor,
                        size: AppSpacings.s35,
                      ),
                      SizedBox(width: AppSpacings.s6),
                      Text(
                        getTranslated(context, 'Filter')!,
                        style: Get.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: AppSpacings.s25,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {

                      controller.tampSelectedJobName.value = "";
                      controller.tampSelectedJobNameId.value = "";
                      controller.selectedJobName.value = "";
                      controller.selectedJobNameId.value = "";


                      controller.tampSelectedVendorName.value = "";
                      controller.tampSelectedVendorNameId.value = "";
                      controller.selectedVendorName.value = "";
                      controller.selectedVendorNameId.value = "";


                      controller.tempFromDate.text = "";
                      controller.tempToDate.text = "";
                      controller.fromDate.value = "";
                      controller.toDate.value = "";

                      controller.textJobName.value.clear();
                      controller.textVendorName.value.clear();
                      controller.jobAllocationPage = 0;
                      controller.jobAllocationList.clear();
                      controller.getJobAllocation();
                      // Get.back();
                    },
                    child: Text(
                      getTranslated(context, 'ClearAll')!,
                      style: Get.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ThemeService.primaryColor,
                        fontSize: AppSpacings.s18,
                      ),
                    ),
                    // CircleAvatar(
                    //   maxRadius: AppSpacings.s22,
                    //   backgroundColor: ThemeService.primaryColor,
                    //   child: Icon(
                    //     Icons.close_rounded,
                    //     size: AppSpacings.s30,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ThemeService.primaryColor,
              height: 0,
              endIndent: 15,
              indent: 15,
              thickness: 3,
            ),
            Expanded(
              child: AnimationLimiter(
                  child: Obx(() => ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: AppSpacings.s25,
                      right: AppSpacings.s25,
                      top: AppSpacings.s30,
                    ),
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 275),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        TextFormField(
                          controller: controller.tempFromDate,
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
                              initialDate: controller.tempFromDate.text != "" ? DateTime.parse(controller.tempFromDate.text.toString()) : DateTime.now(),
                              // initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );
                            if (followUpPickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                              controller.tempFromDate.text = formattedDate;
                              log(controller.tempFromDate.text);
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
                            labelText: getTranslated(context, 'FromDate')!,
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
                          controller: controller.tempToDate,
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
                              initialDate: controller.tempToDate.text != "" ? DateTime.parse(controller.tempToDate.text.toString()) : DateTime.now(),
                              // initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );
                            if (followUpPickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                              controller.tempToDate.text = formattedDate;
                              log(controller.tempToDate.text);
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
                            labelText: getTranslated(context, 'ToDate')!,
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
                        searchDropDwonWidget(
                          selectedValue: controller.tampSelectedJobName,
                          selectedId: controller.tampSelectedJobNameId,
                          emptyTitle: getTranslated(context, 'JobName')!,
                          list: controller.jobNameList,
                          isExpanded: controller.isJobNameExpanded,
                          isSearching: controller.isJobNameSearching,
                          textfield: controller.textJobName,
                        ),
                        if(controller.userTypeID.value == "1")
                          SizedBox(
                            height: AppSpacings.s20,
                          ),
                        if(controller.userTypeID.value == "1")
                          searchDropDwonWidget(
                            selectedValue: controller.tampSelectedVendorName,
                            selectedId: controller.tampSelectedVendorNameId,
                            emptyTitle: getTranslated(context, 'VendorName')!,
                            list: controller.vendorNameList,
                            isExpanded: controller.isVendorNameExpanded,
                            isSearching: controller.isVendorNameSearching,
                            textfield: controller.textVendorName,
                          ),
                        SizedBox(
                          height: AppSpacings.s20,
                        ),
                      ],
                    ),
                  ),)
              ),
            ),
            SizedBox(height: AppSpacings.s30),
            Bounce(
              duration: const Duration(milliseconds: 100),
              onPressed: (){

                controller.selectedJobName.value = controller.tampSelectedJobName.value;
                controller.selectedJobNameId.value = controller.tampSelectedJobNameId.value;
                controller.tampSelectedJobName.value = "";
                controller.tampSelectedJobNameId.value = "";

                controller.selectedVendorName.value = controller.tampSelectedVendorName.value;
                controller.selectedVendorNameId.value = controller.tampSelectedVendorNameId.value;
                controller.tampSelectedVendorName.value = "";
                controller.tampSelectedVendorNameId.value = "";


                controller.fromDate.value = controller.tempFromDate.text;
                controller.toDate.value = controller.tempToDate.text;
                controller.tempFromDate.text = "";
                controller.tempToDate.text = "";

                controller.jobAllocationPage = 0;
                controller.jobAllocationList.clear();
                controller.getJobAllocation();
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: AppSpacings.s25,
                  right: AppSpacings.s25,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ThemeService.white,
                  boxShadow:  [
                    BoxShadow(
                        color: ThemeService.primaryColor.withOpacity(0.5),
                        blurRadius: 9.5,
                        blurStyle: BlurStyle.inner,
                        offset: Offset(1.5,1.5),
                        spreadRadius: 1.5
                    )
                  ],
                  border: Border.all(color: ThemeService.primaryColor.withOpacity(0.8)),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      AppSpacings.s12,
                    ),
                    child: Text(
                      getTranslated(context, 'Apply')!,
                      style: Get.textTheme.headline1!.copyWith(
                        color: ThemeService.black,
                        fontSize: AppSpacings.s22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacings.s30),
          ],
        ),
      ),
    );
  }

  deleteJobAllocation(context,jobAllocationId,jobName){
    return Obx(() => Padding(
      padding:
      EdgeInsets.only(left: Get.width / 25.0, right: Get.width / 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.width * 0.05,
          ),
          Text(
            getTranslated(context, 'AreYouSure')!,
            style: Get.textTheme.titleSmall!.copyWith(
              color: ThemeService.primaryColor,
              fontSize: AppSpacings.s25,
              fontFamily: 'OpenSans-Semibold',
            ),
          ),
          SizedBox(
            height: Get.width * 0.05,
          ),
          Text(
            '${getTranslated(context, 'YouWantToDeleteThisJob')!}\n( $jobName )',
            style: Get.textTheme.bodyLarge!.copyWith(
              color: ThemeService.black,
              fontSize: AppSpacings.s20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: AppSpacings.s30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bounce(
                duration: const Duration(milliseconds: 100),
                onPressed: () async {
                  Get.back();
                },
                child: Container(
                  width: AppSpacings.s90,
                  padding: EdgeInsets.all(AppSpacings.s8),
                  decoration: BoxDecoration(
                    color: ThemeService.primaryColor,
                    borderRadius: BorderRadius.circular(AppSpacings.s15),
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, 'Cancel')!,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: Get.width * 0.040,
                        fontWeight: FontWeight.w600,
                        color: ThemeService.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: AppSpacings.s20,
              ),
              controller.isDeleteJobAllocation.value
                  ? SizedBox(
                  width: AppSpacings.s90,
                  child: CupertinoActivityIndicator(radius: AppSpacings.s15))
                  :  Bounce(
                duration: const Duration(milliseconds: 100),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  controller.deleteJobAllocation(context,jobAllocationId: jobAllocationId);
                },
                child: Container(
                  width: AppSpacings.s90,
                  padding:  EdgeInsets.all(AppSpacings.s8),
                  decoration: BoxDecoration(
                    color: ThemeService.primaryColor,
                    borderRadius: BorderRadius.circular(AppSpacings.s15),
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, 'Delete')!,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: Get.width * 0.040,
                        fontWeight: FontWeight.w600,
                        color: ThemeService.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.width * 0.03,
          ),
        ],
      ),
    ),);
  }

}
