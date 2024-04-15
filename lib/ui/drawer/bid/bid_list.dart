// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';

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
import 'package:mudara_steel_app/common/widget/dropdown_widget/searchable_drop_down_widget.dart';
import 'package:mudara_steel_app/common/widget/lead_card_widget.dart';
import 'package:mudara_steel_app/controllers/bid_controller/bid_list_controller.dart';
import 'package:mudara_steel_app/controllers/job_controller/job_list_controller.dart';
import 'package:mudara_steel_app/controllers/vendor_controller/vendor_list_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';


class BidListScreen extends GetView<BidListController> {
  BidListScreen({Key? key}) : super(key: key);

  BidListController controller = Get.put(BidListController());

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
                            "Job Bid List",
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
                  child:  ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      ListView.builder(
                          padding: EdgeInsets.only(
                            left: AppSpacings.s20,
                            right: AppSpacings.s20,
                            bottom: AppSpacings.s20,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: controller.jobList.length,
                          itemCount: 10,
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
                                    title1: "15/04/24",
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
                                      height: 10,
                                      endIndent: 15,
                                      indent: 15,
                                      color: ThemeService.primaryColor,
                                      thickness: 2),
                                  dataRow(
                                    title1: "Job Name",
                                    value1: "Job-1",
                                    title2: "Vendor Name",
                                    value2:  "Suresh",
                                  ),
                                  Divider(
                                      height: 10,
                                      endIndent: 15,
                                      indent: 15,
                                      color: ThemeService.primaryColor.withOpacity(0.2),
                                      thickness: 1),
                                  dataRow(
                                    title1: "Cost",
                                    value1: "5200",
                                    title2: "Remark",
                                    value2: "GFS",
                                  ),
                                  // Divider(
                                  //     height: 10,
                                  //     endIndent: 15,
                                  //     indent: 15,
                                  //     color: ThemeService.primaryColor.withOpacity(0.2),
                                  //     thickness: 1),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s10),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     children: [
                                  //       Container(
                                  //         padding: EdgeInsets.symmetric(horizontal: AppSpacings.s20, vertical: AppSpacings.s8),
                                  //         decoration: BoxDecoration(
                                  //             color: ThemeService.white,
                                  //             boxShadow:  [
                                  //               BoxShadow(
                                  //                   color: ThemeService.primaryColor.withOpacity(0.5),
                                  //                   blurRadius: 9.5,
                                  //                   blurStyle: BlurStyle.inner,
                                  //                   offset: const Offset(1.5,1.5),
                                  //                   spreadRadius: 1.0
                                  //               )
                                  //             ],
                                  //             border: Border.all(
                                  //               color: ThemeService.primaryColor,
                                  //             ),
                                  //             borderRadius: BorderRadius.circular(12)),
                                  //         child: const Center(
                                  //             child: Icon(Icons.delete,color: ThemeService.primaryColor,)
                                  //           // Text(
                                  //           //   "Update",
                                  //           //   style: Get.textTheme.headlineLarge!.copyWith(
                                  //           //     color: ThemeService.primaryColor,
                                  //           //     fontSize: AppSpacings.s20,
                                  //           //     fontWeight: FontWeight.w600,
                                  //           //   ),
                                  //           // ),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: AppSpacings.s15,
                                  //       ),
                                  //       GestureDetector(
                                  //         onTap: (){
                                  //           Get.toNamed(Routes.createJob,arguments: {
                                  //             "jobName" : "Job",
                                  //             "fromLocation":"Ahmedabad",
                                  //             "toLocation" :"Surat",
                                  //             "deliveryDate":"16/01/24",
                                  //             "weight":"32"
                                  //           });
                                  //         },
                                  //         child: Container(
                                  //           padding: EdgeInsets.symmetric(horizontal: AppSpacings.s20, vertical: AppSpacings.s8),
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
                                  //           child: const Center(
                                  //               child: Icon(Icons.edit,color: ThemeService.primaryColor,)
                                  //             // Text(
                                  //             //   "Delete",
                                  //             //   style: Get.textTheme.headlineLarge!.copyWith(
                                  //             //     color: ThemeService.primaryColor,
                                  //             //     fontSize: AppSpacings.s20,
                                  //             //     fontWeight: FontWeight.w600,
                                  //             //   ),
                                  //             // ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            );
                          }
                      ),
                      if (controller.isVendorListLoading.value == true)  Padding(
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
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        controller: controller.toDate,
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
                            initialDate: controller.toDate.text != "" ? DateTime.parse(controller.toDate.text.toString()) : DateTime.now(),
                            // initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime(DateTime.now().year + 10),
                          );
                          if (followUpPickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                            controller.toDate.text = formattedDate;
                            log(controller.toDate.text);
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
                        controller: controller.fromDate,
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
                            initialDate: controller.fromDate.text != "" ? DateTime.parse(controller.fromDate.text.toString()) : DateTime.now(),
                            // initialDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime(DateTime.now().year + 10),
                          );
                          if (followUpPickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(followUpPickedDate);
                            controller.fromDate.text = formattedDate;
                            log(controller.fromDate.text);
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
    );
  }

}
