// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, unrelated_type_equality_checks


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/dropdown_below.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_list_controller.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/Job/complited_job_list.dart';
import 'package:mudara_steel_app/ui/drawer/AdminLogin/Job/open_job_list.dart';

class JobListScreen extends GetView<JobListController> {
  const JobListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobListController controller = Get.put(JobListController());
    return Obx(() => Scaffold(
      backgroundColor: ThemeService.white,
      body: Column(
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
          TabBar(
            controller: controller.tabController.value,
            labelColor:  ThemeService.primaryColor,
            unselectedLabelColor: ThemeService.subTitle,
            // indicatorColor: controller.currentTab == 0 ?  ThemeService.pendingColor: ThemeService.completedColor,
            indicatorColor: ThemeService.primaryColor,
            automaticIndicatorColorAdjustment: true,
            dividerColor: ThemeService.disable,
            labelStyle: Get.textTheme.titleLarge!.copyWith(
              fontSize: AppSpacings.s18,
              fontWeight: FontWeight.w700,
            ),
            indicatorPadding: EdgeInsets.only(
              left: AppSpacings.s16,
              right: AppSpacings.s16,
            ),
            labelPadding: EdgeInsets.zero,
            indicatorWeight: 4,
            isScrollable: false,
            // padding:EdgeInsets.only(
            //     left: AppSpacings.s16,
            //     right: AppSpacings.s16,
            //   ),
            tabAlignment: TabAlignment.fill,
            indicatorSize:TabBarIndicatorSize.tab,
            onTap: (index){
              Future.delayed(const Duration(milliseconds: 100),(){
                controller.currentTab.value = index;
              });

            },
            tabs: const [
              Tab(
                text: "Open",
              ),
              Tab(
                text: "Complited",
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: ThemeService.backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: AppSpacings.s20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset('assets/myroute_assets/route.png',
                  //       width: AppSpacings.s30,
                  //     ),
                  //     SizedBox(width: AppSpacings.s10),
                  //     RichText(
                  //       text: TextSpan(
                  //           text: 'Surat To Navsari',
                  //           style: TextStyle(
                  //             color: ThemeService.primaryColor,
                  //             fontSize: AppSpacings.s25,
                  //             fontWeight: FontWeight.w700,
                  //             fontFamily: 'OpenSans-Semibold',
                  //           ),
                  //           children: <TextSpan>[
                  //             TextSpan(text:'  - 15-11-2023 ',
                  //               style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: AppSpacings.s22,
                  //                 fontWeight: FontWeight.w500,
                  //                 fontFamily: 'OpenSans-Semibold',
                  //               ),
                  //             )
                  //           ]
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: AppSpacings.s10),
                  // Divider(
                  //     indent: AppSpacings.s20,
                  //     endIndent: AppSpacings.s20,
                  //     color: ThemeService.grayScale),
                  Expanded(
                    child: TabBarView(
                        controller: controller.tabController.value,
                        physics: const BouncingScrollPhysics(),
                        children:[
                          OpenJobListScreen(),
                          ComplitedJobListScreen(),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                      controller.openJobList.clear();
                      controller.getOpenJob();
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
                controller.openJobList.clear();
                controller.getOpenJob();
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

}


