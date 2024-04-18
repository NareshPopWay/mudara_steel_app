// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/dropdown_below.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/common/widget/empty_widget.dart';
import 'package:mudara_steel_app/common/widget/lead_card_widget.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_list_controller.dart';
import 'package:mudara_steel_app/controllers/vendor_controller/vendor_list_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class JobListScreen extends GetView<JobListController> {
  JobListScreen({Key? key}) : super(key: key);

  JobListController controller = Get.put(JobListController());

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
                            controller.appTitle.value,
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
                                  "Show",
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
                                  constraints: const BoxConstraints(maxHeight:500),
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
                height: AppSpacings.s2,
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
                          placeholder: 'Search Job',
                          controller: controller.searchTextEditController,
                          placeholderStyle: TextStyle(
                              fontSize: AppSpacings.s18,
                              color: Get.theme.disabledColor),
                          onSuffixTap: () {
                            // controller.isMemberSearching.value = false;
                            // controller.memberSearchResult.clear();
                            controller.searchTextEditController.clear();
                            controller.jobPage = 0;
                            controller.jobList.clear();
                            controller.getJob();
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
                                controller.jobPage = 0;
                                controller.jobList.clear();
                                controller.getJob();
                              });
                            }else if(value.isEmpty){
                              EasyDebounce.debounce('lead', const Duration(milliseconds: 700), () {
                                controller.jobPage = 0;
                                controller.jobList.clear();
                                controller.getJob();
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
                      controller.jobPage = 0;
                      controller.jobList.clear();
                      controller.getJob();
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
                    controller: controller.leadScrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(0,0, 0, AppSpacings.s55),
                    primary: false,
                    physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                    children: [
                      if (controller.jobList.isEmpty && !controller.isJobListLoading.value)
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
                          itemCount: controller.jobList.length,
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
                                  headerRow1(
                                    title1: controller.jobList[index].createdOn != null
                                        ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.jobList[index].createdOn.toString()))
                                        : "-",
                                    icon1: Icon(Icons.calendar_month, size: AppSpacings.s25),
                                    title2: controller.jobList[index].jobName ?? "-",
                                    icon2: null,
                                  ),
                                  // Container(
                                  //   height: AppSpacings.s50,
                                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Expanded(
                                  //         flex:4,
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.start,
                                  //           children: [
                                  //             Icon(Icons.calendar_month, size: AppSpacings.s25),
                                  //             Text(
                                  //               controller.jobList[index].createdOn != null
                                  //                   ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.jobList[index].createdOn.toString()))
                                  //                   : "-",
                                  //               overflow: TextOverflow.ellipsis,
                                  //               style: Get.textTheme.displayMedium!.copyWith(
                                  //                 color: Colors.black,
                                  //                 fontWeight: FontWeight.w700,
                                  //                 fontSize: AppSpacings.s20,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         flex: 1,
                                  //         child: Row(
                                  //           mainAxisAlignment: MainAxisAlignment.end,
                                  //           children: [
                                  //             Expanded(
                                  //               child: Text(
                                  //                 controller.jobList[index].jobName ?? "-",
                                  //                 style: Get.textTheme.displayMedium!.copyWith(
                                  //                   color: Colors.black,
                                  //                   fontWeight: FontWeight.w700,
                                  //                   fontSize: AppSpacings.s20,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
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
                                    title1: "From Location",
                                    value1: controller.jobList[index].fromLocation ?? "-",
                                    title2: "To Location",
                                    value2:  controller.jobList[index].toLocation ?? "-",
                                  ),
                                  Divider(
                                      height: 2,
                                      endIndent: 10,
                                      indent: 10,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),
                                  dataRow(
                                    title1: "Delivery Date",
                                    value1: controller.jobList[index].deliveryDate != null
                                        ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.jobList[index].deliveryDate.toString()))
                                        : "-",
                                    title2: "Weight",
                                    value2: controller.jobList[index].weight.toString() ?? "-",
                                  ),
                                  Divider(
                                      height: 2,
                                      endIndent: 10,
                                      indent: 10,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),
                                  dataRow(
                                    title1: "Job Status",
                                    value1: controller.jobList[index].jobStatus ?? "-",
                                    title2: "Job Type",
                                    value2: controller.jobList[index].jobType ?? "-",
                                  ),
                                  Divider(
                                      height: 2,
                                      endIndent: 10,
                                      indent: 10,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),

                                       ///Admin Login
                                       if(controller.userTypeID.value == "1")
                                       Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Truck/Trailer",
                                                style: Get.textTheme.bodyText2!.copyWith(
                                                  color: ThemeService.disable,
                                                  fontSize: AppSpacings.s15,
                                                ),
                                              ),
                                              Text(
                                                controller.jobList[index].isTruck == true ? "Truck" : "Trailer",
                                                style: Get.textTheme.headline4!.copyWith(
                                                  fontSize: AppSpacings.s18,
                                                  color: ThemeService.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Bounce(
                                              duration: Duration(milliseconds: 100),
                                              onPressed: () {
                                                showGeneralDialog(
                                                    transitionDuration:
                                                    const Duration(milliseconds: 400),
                                                    barrierDismissible: true,
                                                    barrierLabel: '',
                                                    pageBuilder: (ctx, a1, a2) {
                                                      return Container();
                                                    },
                                                    context: context,
                                                    transitionBuilder: (ctx, a1, a2, child) {
                                                      // var curve = Curves.easeInOutCubic .transform(a1.value);
                                                      return SlideTransition(
                                                        position: Tween(
                                                            begin: const Offset(0, 1),
                                                            end: const Offset(0, 0))
                                                            .animate(a1),
                                                        child: Opacity(
                                                          opacity: a1.value,
                                                          child: AlertDialog(
                                                            elevation: 5,
                                                            surfaceTintColor: ThemeService.white,
                                                            shadowColor:ThemeService.primaryColor.withOpacity(.5),
                                                            contentPadding: const EdgeInsets.all(5.0),
                                                            shape: const RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                color: ThemeService.primaryColor,
                                                                style: BorderStyle.solid,
                                                              ),
                                                              borderRadius: BorderRadius.all(
                                                                Radius.circular(25.0),
                                                              ),
                                                            ),
                                                            titlePadding: EdgeInsets.zero,
                                                            content: deleteJob(context,controller.jobList.isNotEmpty ? controller.jobList[index].jobId:0 , controller.jobList.isNotEmpty ? controller.jobList[index].jobName:''),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: AppSpacings.s20, vertical: AppSpacings.s8),
                                                decoration: BoxDecoration(
                                                    color: ThemeService.white,
                                                    boxShadow:  [
                                                      BoxShadow(
                                                          color: ThemeService.primaryColor.withOpacity(0.5),
                                                          blurRadius: 9.5,
                                                          blurStyle: BlurStyle.inner,
                                                          offset: const Offset(1.5,1.5),
                                                          spreadRadius: 1.0
                                                      )
                                                    ],
                                                    border: Border.all(
                                                      color: ThemeService.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12)),
                                                child: const Center(
                                                  child: Icon(Icons.delete,color: ThemeService.primaryColor,)
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppSpacings.s15,
                                            ),
                                            Bounce(
                                              duration: Duration(milliseconds: 100),
                                              onPressed: (){
                                                Get.toNamed(
                                                  Routes.createJob,
                                                  arguments: controller.jobList[index].jobId.toString(),
                                                );
                                                // Get.toNamed(Routes.createJob,arguments: {
                                                //   "jobName" : controller.jobList[index].jobName,
                                                //   "fromLocation":controller.jobList[index].fromLocation,
                                                //   "toLocation" :controller.jobList[index].toLocation,
                                                //   "deliveryDate":controller.jobList[index].deliveryDate != null
                                                //       ? DateFormat("dd/MM/yyyy").format(DateTime.parse(controller.jobList[index].deliveryDate.toString()))
                                                //       : "-",
                                                //   "weight":controller.jobList[index].weight ?? ""
                                                // });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: AppSpacings.s20, vertical: AppSpacings.s8),
                                                decoration: BoxDecoration(
                                                    color: ThemeService.white,
                                                    boxShadow:  [
                                                      BoxShadow(
                                                          color: ThemeService.primaryColor.withOpacity(0.5),
                                                          blurRadius: 9.5,
                                                          blurStyle: BlurStyle.inner,
                                                          offset: const Offset(1.5,1.5),
                                                          spreadRadius: 1.0
                                                      )
                                                    ],
                                                    border: Border.all(
                                                      color: ThemeService.primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius.circular(12)),
                                                child: const Center(
                                                    child: Icon(Icons.edit,color: ThemeService.primaryColor,)
                                                  // Text(
                                                  //   "Delete",
                                                  //   style: Get.textTheme.headlineLarge!.copyWith(
                                                  //     color: ThemeService.primaryColor,
                                                  //     fontSize: AppSpacings.s20,
                                                  //     fontWeight: FontWeight.w600,
                                                  //   ),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                   )
                                       else
                                      ///Vendor Login
                                      Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Truck/Trailer",
                                            style: Get.textTheme.bodyText2!.copyWith(
                                              color: ThemeService.disable,
                                              fontSize: AppSpacings.s15,
                                            ),
                                          ),
                                          Text(
                                            controller.jobList[index].isTruck == true ? "Truck" : "Trailer",
                                            style: Get.textTheme.headline4!.copyWith(
                                              fontSize: AppSpacings.s18,
                                              color: ThemeService.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Bounce(
                                      duration: const Duration(milliseconds: 100),
                                      onPressed: (){
                                                // controller.saveBide(context,jobId:controller.jobList[index].jobId,cost: )
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: AppSpacings.s20, vertical: AppSpacings.s8),
                                        decoration: BoxDecoration(
                                            color: ThemeService.white,
                                            boxShadow:  [
                                              BoxShadow(
                                                  color: ThemeService.primaryColor.withOpacity(0.5),
                                                  blurRadius: 9.5,
                                                  blurStyle: BlurStyle.inner,
                                                  offset: const Offset(1.5,1.5),
                                                  spreadRadius: 1.0
                                              )
                                            ],
                                            border: Border.all(
                                              color: ThemeService.primaryColor,
                                            ),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Center(
                                          child: Text(
                                            "Apply",
                                            style: Get.textTheme.headlineLarge!.copyWith(
                                              color: ThemeService.primaryColor,
                                              fontSize: AppSpacings.s20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                                  SizedBox(height: AppSpacings.s5),
                                ],
                              ),
                            );
                          }
                      ),
                      if (controller.isJobListLoading.value == true)  Padding(
                        padding: EdgeInsets.fromLTRB(0, AppSpacings.s150, 0,0),
                        child: CupertinoActivityIndicator(radius: AppSpacings.s20,),
                      )
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

    controller.tampSelectedJobStatus.value = controller.selectedJobStatus.value;
    controller.tampSelectedJobStatusId.value = controller.selectedJobStatusId.value;

    controller.tampSelectedJobType.value = controller.selectedJobType.value;
    controller.tampSelectedJobTypeId.value = controller.selectedJobTypeId.value;

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
                        "Filter",
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

                      controller.tampSelectedJobStatus.value = "";
                      controller.tampSelectedJobStatusId.value = "";
                      controller.selectedJobStatus.value = "";
                      controller.selectedJobStatusId.value = "";

                      controller.tampSelectedJobType.value = "";
                      controller.tampSelectedJobTypeId.value = "";
                      controller.selectedJobType.value = "";
                      controller.selectedJobTypeId.value = "";


                      controller.tempFromDate.text = "";
                      controller.tempToDate.text = "";

                      controller.fromDate.value = "";
                      controller.toDate.value = "";

                      controller.textJobName.value.clear();
                      controller.textJobStatus.value.clear();
                      controller.textJobType.value.clear();
                      controller.jobPage = 0;
                      controller.jobList.clear();
                      controller.getJob();
                      // Get.back();
                    },
                    child: Text(
                      "Clear all",
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
                            labelText: "From Date",
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
                            labelText: "To Date",
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
                          emptyTitle: "Job Name",
                          list: controller.jobNameList,
                          isExpanded: controller.isJobNameExpanded,
                          isSearching: controller.isJobNameSearching,
                          textfield: controller.textJobName,
                        ),
                        SizedBox(
                          height: AppSpacings.s20,
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
                        SizedBox(
                          height: AppSpacings.s20,
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

                controller.selectedJobStatus.value = controller.tampSelectedJobStatus.value;
                controller.selectedJobStatusId.value = controller.tampSelectedJobStatusId.value;
                controller.tampSelectedJobStatus.value = "";
                controller.tampSelectedJobStatusId.value = "";

                controller.selectedJobType.value = controller.tampSelectedJobType.value;
                controller.selectedJobTypeId.value = controller.tampSelectedJobTypeId.value;
                controller.tampSelectedJobType.value = "";
                controller.tampSelectedJobTypeId.value = "";

                controller.toDate.value = controller.tempToDate.text;
                controller.fromDate.value = controller.tempFromDate.text;

                controller.tempFromDate.text = "";
                controller.tempToDate.text = "";

                controller.jobPage = 0;
                controller.jobList.clear();
                controller.getJob();
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
                        offset: const Offset(1.5,1.5),
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
                      "Apply",
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
            // TextButton(
            //   style: TextButton.styleFrom(
            //     foregroundColor: ThemeService.white,
            //     backgroundColor: ThemeService.primaryColor,
            //     // shape: RoundedRectangleBorder(
            //     //   side: const BorderSide(
            //     //     color: ThemeService.primaryColor,
            //     //     width: 1.5,
            //     //   ),
            //     //   borderRadius: BorderRadius.circular(30.0),
            //     // ),
            //   ),
            //   onPressed: () async {
            //
            //   },
            //   child: Text("Apply", style: Get.textTheme.displayMedium!.copyWith(color: ThemeService.white)),
            // ),

          ],
        ),
      ),
    );
  }

  
  deleteJob(context,jobId,jobName){
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
            'Are you sure?',
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
            'You want to delete this job\n( $jobName )',
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
                      "Cancel",
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
              Bounce(
                duration: const Duration(milliseconds: 100),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  controller.deleteJob(context,jobId: jobId);
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
                      "Delete",
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
