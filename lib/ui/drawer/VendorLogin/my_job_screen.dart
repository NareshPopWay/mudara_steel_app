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
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_job_controller.dart';
import 'package:mudara_steel_app/controllers/VendorLoginControllers/my_open_job_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/my_completed_job_screen.dart';
import 'package:mudara_steel_app/ui/drawer/VendorLogin/my_open_job_screen.dart';


class MyJobScreen extends GetView<MyJobController> {
  MyJobScreen({Key? key}) : super(key: key);

  MyJobController controller = Get.put(MyJobController());

  @override
  Widget build(BuildContext context) {
    final MyJobController controller = Get.put(MyJobController());
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
                        'Job List',
                        style: Get.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ThemeService.primaryColor,
                          fontSize: AppSpacings.s25,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       height: 35,
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "Show",
                  //             style: Get.textTheme.displaySmall!.copyWith(fontSize: AppSpacings.s18),
                  //           ),
                  //           SizedBox(
                  //             width: AppSpacings.s5,
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.fromLTRB(AppSpacings.s10, 0, AppSpacings.s10, 0),
                  //             decoration: BoxDecoration(color: ThemeService.primaryColor, borderRadius: BorderRadius.circular(10)),
                  //             child:DropdownBelow(
                  //                 itemWidth: 80,
                  //                 itemTextstyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black,fontFamily:'Poppins-Medium'),
                  //                 boxTextstyle: Get.textTheme.displaySmall!.copyWith(fontSize: AppSpacings.s16,color: Colors.white),
                  //                 boxHeight: 50,
                  //                 icon: const Icon(Icons.keyboard_arrow_down,color: ThemeService.white),
                  //                 boxWidth: 50,
                  //                 hint: Text('${controller.showCountVal.value}'),
                  //                 value: controller.showCountVal.value,
                  //                 items: controller.buildsShowCountItems(controller.showCount),
                  //                 onChanged: controller.onChangeShowCount
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(width: AppSpacings.s5),
                  //     GestureDetector(
                  //       onTap: ()async{
                  //         await showModalBottomSheet(
                  //             context: context,
                  //             backgroundColor: ThemeService.white,
                  //             elevation: 5.5,
                  //             useSafeArea: true,
                  //             constraints: const BoxConstraints(maxHeight:500),
                  //             isScrollControlled:true,
                  //             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                  //             builder: (context){
                  //               return Filter(context);
                  //             }
                  //         );
                  //       },
                  //       child: Center(
                  //         child: Container(
                  //           decoration:  BoxDecoration(
                  //               color: ThemeService.primaryColor,
                  //               borderRadius: BorderRadius.circular(10)
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(6.0),
                  //             child: Image.asset(
                  //               "assets/filter.png",
                  //               height: AppSpacings.s30,
                  //               color: ThemeService.white,
                  //               alignment: Alignment.center,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                          MyOpenJobScreen(),
                          MyCompletedJobScreen(),
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

}
