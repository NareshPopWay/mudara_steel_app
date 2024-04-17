// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mudara_steel_app/common/api_provider.dart';
import 'package:mudara_steel_app/common/loader/custome_loader.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/common/widget/empty_widget.dart';
import 'package:mudara_steel_app/common/widget/lead_card_widget.dart';
import 'package:mudara_steel_app/controllers/bid_controller/bid_list_controller.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_allocation_list_controller.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_list_controller.dart';
import 'package:mudara_steel_app/controllers/vendor_controller/vendor_list_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class JobAllocationListScreen extends GetView<JobAllocationListController> {
  JobAllocationListScreen({Key? key}) : super(key: key);

  JobAllocationListController controller = Get.put(JobAllocationListController());

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
                                    title1: "Job Name",
                                    value1: controller.jobAllocationList[index].jobName ?? "-",
                                    title2: "Vendor Name",
                                    value2:  controller.jobAllocationList[index].vendorName ?? "-",
                                  ),
                                  Divider(
                                      height: 2,
                                      endIndent: 10,
                                      indent: 10,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),
                                  dataRow(
                                    title1: "Cost",
                                    value1: controller.jobAllocationList[index].cost.toString() ?? "-",
                                    title2: "Remark",
                                    value2: controller.jobAllocationList[index].remark ?? "-",
                                  ),
                                  Divider(
                                      height: 2,
                                      endIndent: 10,
                                      indent: 10,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),

                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s10),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     children: [
                                  //       // dataColumn(
                                  //       //   title: "City",
                                  //       //   value:  "Surat",
                                  //       // ),
                                  //       Bounce(
                                  //         duration: const Duration(milliseconds: 100),
                                  //         onPressed: (){
                                  //
                                  //         },
                                  //         child: Container(
                                  //           padding: EdgeInsets.symmetric(horizontal: AppSpacings.s25, vertical: AppSpacings.s8),
                                  //           decoration: BoxDecoration(
                                  //               color: ThemeService.white,
                                  //               boxShadow:  [
                                  //                 BoxShadow(
                                  //                     color: ThemeService.primaryColor.withOpacity(0.5),
                                  //                     blurRadius: 9.5,
                                  //                     blurStyle: BlurStyle.inner,
                                  //                     offset: const Offset(1.5,1.5),
                                  //                     spreadRadius: 1.0
                                  //                 )
                                  //               ],
                                  //               border: Border.all(
                                  //                 color: ThemeService.primaryColor,
                                  //               ),
                                  //               borderRadius: BorderRadius.circular(12)),
                                  //           child: Center(
                                  //             child: Text(
                                  //               "Allocation",
                                  //               style: Get.textTheme.headlineLarge!.copyWith(
                                  //                 color: ThemeService.primaryColor,
                                  //                 fontSize: AppSpacings.s20,
                                  //                 fontWeight: FontWeight.w600,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s10),
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ///delete
                                        Bounce(
                                          duration: const Duration(milliseconds: 100),
                                          onPressed: (){
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
                                                      child: Dialog(
                                                        elevation: 5,
                                                        surfaceTintColor: ThemeService.white,
                                                        backgroundColor: ThemeService.white,
                                                        // shadowColor:ThemeService.primaryColor.withOpacity(.5),
                                                        insetPadding: EdgeInsets.only(
                                                            left: AppSpacings.s15,
                                                            top: 0,
                                                            right: AppSpacings.s15,
                                                            bottom: AppSpacings.s15),
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(25),
                                                          ),
                                                        ),
                                                        child: deleteJobAllocation(context,controller.jobAllocationList.isNotEmpty ? controller.jobAllocationList[index].jobId:0 , controller.jobAllocationList.isNotEmpty ? controller.jobAllocationList[index].jobName:''),
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
                                        ///Update
                                        Bounce(
                                          duration: const Duration(milliseconds: 100),
                                          onPressed: ()async{

                                            Get.toNamed(
                                              Routes.createJobAllocation,
                                              arguments: controller.jobAllocationList[index].jobAllocationId,
                                            );
                                            // // controller.vendorJobBidList.value = await APIProvider().getVendorJobBide(jobId:controller.jobAllocationList[index].jobId);
                                            // controller.getJobAllocationById(jobAllocationId:controller.jobAllocationList[index].jobAllocationId);

                                            // await showModalBottomSheet(
                                            // context: context,
                                            // backgroundColor: ThemeService.white,
                                            // elevation: 5.5,
                                            // useSafeArea: true,
                                            // constraints: const BoxConstraints(maxHeight:500),
                                            // isScrollControlled:true,
                                            // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                                            //     topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                                            // builder: (context){
                                            //   return updateJobAllocation(
                                            //     context,
                                            //     selectedJobName1:controller.jobAllocationList[index].jobName,
                                            //     selectedJobName1Id: controller.jobAllocationList[index].jobId.toString(),
                                            //     selectedVendorJobBid:controller.selectedVendorJobBid.value,
                                            //     selectedVendorJobBidId: controller.selectedVendorJobBidId.value,
                                            //     cost:controller.jobAllocationList[index].cost.toString() ?? "-",
                                            //     remark: controller.jobAllocationList[index].remark ?? "-",
                                            //   );
                                            // }
                                            // );

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
                      if (controller.isJobAllocationListLoading.value == true)  Padding(
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
                          selectedValue: controller.tampSelectedVendorName,
                          selectedId: controller.tampSelectedVendorNameId,
                          emptyTitle: "Vendor Name",
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

  deleteJobAllocation(context,jobId,jobName) {
    return Obx(() => SizedBox(
      height: Get.height *.30,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            left: AppSpacings.s20,
            top: AppSpacings.s30,
            right: AppSpacings.s20,
            bottom: AppSpacings.s15),
        children: [
          Center(
            child: Text(
              'Are you sure?',
              style: Get.textTheme.titleSmall!.copyWith(
                color: ThemeService.primaryColor,
                fontSize: AppSpacings.s25,
                fontFamily: 'OpenSans-Semibold',
              ),
            ),
          ),
          SizedBox(
            height: AppSpacings.s20,
          ),
          Center(
            child: Text(
              'You want to delete this job $jobName',
              style: Get.textTheme.titleSmall!.copyWith(
                color: ThemeService.primaryColor,
                fontSize: AppSpacings.s18,
                fontFamily: 'OpenSans-Semibold',
              ),
            ),
          ),
          SizedBox(
            height: AppSpacings.s40,
          ),
          controller.isDeleteJobAllocation.value
              ? CupertinoActivityIndicator(radius: AppSpacings.s20)
              : Bounce(
            duration: const Duration(milliseconds: 150),
            onPressed: () async {
                FocusScope.of(context).unfocus();
                controller.deleteJobAllocation(context,jobId: jobId);

            },
            child: Container(
              decoration: BoxDecoration(
                color: ThemeService.primaryColor,
                borderRadius: BorderRadius.circular(25),
                // boxShadow: [
                //   BoxShadow(
                //     color: ThemeService.primaryColor
                //         .withOpacity(0.5),
                //     spreadRadius: 1.5,
                //     blurRadius: 10,
                //     offset: const Offset(0, 2),
                //   ),
                // ]
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(
                    AppSpacings.s12,
                  ),
                  child: Text(
                    "Delete",
                    style: Get.textTheme.headline1!.copyWith(
                      color: ThemeService.white,
                      fontSize: AppSpacings.s25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: AppSpacings.s10),
        ],
      ),
    ));
  }

  updateJobAllocation(context,{
    String? selectedJobName1,
    String? selectedJobName1Id,
    String? selectedVendorJobBid,
    String? selectedVendorJobBidId,
    String? cost,
    String? remark
  }) {

    controller.selectedJobName1.value = selectedJobName1!;
    controller.selectedJobName1Id.value = selectedJobName1Id!;

    controller.selectedVendorJobBid.value = selectedVendorJobBid!;
    controller.selectedVendorJobBidId.value = selectedVendorJobBidId!;

    controller.cost.text = cost ?? "";
    controller.remark.text = remark ?? "";

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
                        "Update Data",
                        style: Get.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: AppSpacings.s25,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                       Get.back();
                    },
                    child: Text(
                      "Close",
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
                        searchDropDwonWidget(
                          selectedValue: controller.selectedJobName1,
                          selectedId: controller.selectedJobName1Id,
                          emptyTitle: "Job Name",
                          list: controller.jobName1List,
                          isExpanded: controller.isJobName1Expanded,
                          isSearching: controller.isJobName1Searching,
                          textfield: controller.textJobName1,
                        ),
                        SizedBox(
                          height: AppSpacings.s15,
                        ),
                        searchDropDwonWidget(
                          selectedValue: controller.selectedVendorJobBid,
                          selectedId: controller.selectedVendorJobBidId,
                          emptyTitle: "Vendor Job Bid",
                          list: controller.vendorJobBidList,
                          isExpanded: controller.isVendorJobBidExpanded,
                          isSearching: controller.isVendorJobBidSearching,
                          textfield: controller.textVendorJobBid,
                        ),
                        SizedBox(
                          height: AppSpacings.s20,
                        ),
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
                          keyboardType: TextInputType.number,
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
                  ),)
              ),
            ),
            SizedBox(height: AppSpacings.s30),
            Bounce(
              duration: const Duration(milliseconds: 100),
              onPressed: (){

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
                      "Update",
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
