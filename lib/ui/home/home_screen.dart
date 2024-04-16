
// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/controllers/auth_controller.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class HomeScreen extends GetView<RootController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
        init: RootController(),
        initState: (c)async{
          // await Future.delayed(const Duration(milliseconds: 200));
          // controller.visible.value = true;
          //   if(controller.employeeTypeID.value == 1 || controller.employeeTypeID.value == "1") {
          //     String listOfDrawer = await GetStorage().read(Constants.drawerList);
          //     controller.drawer.value = listOfDrawer.split(',');
          //   }else{
          //     controller.empRightList.value = await APIProvider().getEmpRights();
          //     log("${controller.empRightList[1].isInsert}");
          //   }
        },
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            key: GlobalKey(),
            appBar: AppBar(
              excludeHeaderSemantics: true,
              // systemOverlayStyle:  SystemUiOverlayStyle( statusBarColor: ThemeService.primaryColor.withOpacity(0.2),),
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/menu1.png",
                      height: AppSpacings.s30,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              actions: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              ],
            ),
            body: Image.asset(
              "assets/splash_screen.jpeg",
              width: Get.width,
              height: Get.height,
              fit: BoxFit.contain,
            ),
            // Obx(() => Stack(
            //   children: [
            //     AnimatedOpacity(
            //       opacity: controller.visible.value ? 1.0 : 0.0,
            //       duration: const Duration(seconds: 2),
            //       child: Image.asset(
            //         "assets/appcover.jpg",
            //         width: Get.width,
            //         height: Get.height,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     Positioned(
            //       top: AppSpacings.s230,
            //       left: AppSpacings.s80,
            //       child: AnimatedOpacity(
            //         opacity: controller.visible.value ? 1.0 : 0.0,
            //         duration: const Duration(seconds: 2),
            //         child: Container(
            //           height: AppSpacings.s100,
            //           padding: const EdgeInsets.all(10),
            //           child: Image.asset(
            //             'assets/splash_logo1.png',
            //             fit: BoxFit.fill,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )),
            drawer: Drawer(
              backgroundColor: ThemeService.white,
              surfaceTintColor: ThemeService.white,
              elevation: 5,
              shadowColor: Colors.white,
              width: AppSpacings.s350,
              child: Column(
                children: [
                  if(controller.userTypeID.value == "1")
                  ///Admin Login
                  Container(
                    height: AppSpacings.s200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ThemeService.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                      border: Border(
                          bottom: BorderSide(
                              color: ThemeService.primaryColor.withOpacity(0.5),
                              width: AppSpacings.s3)),
                    ),
                    padding:EdgeInsets.only(top: AppSpacings.s45,right:AppSpacings.s20,left: AppSpacings.s20,bottom: AppSpacings.s20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: AppSpacings.s12),
                        CircleAvatar(
                          backgroundColor: ThemeService.primaryColor.withOpacity(0.6),
                          maxRadius: AppSpacings.s35,
                          child: Obx(
                                () => Text(
                              controller.userName.value != "" ? controller.userName.value.characters.first.toUpperCase() : "U",
                              style: TextStyle(fontSize: AppSpacings.s30, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacings.s12),
                        Obx(
                              () => Expanded(
                            child: Text(
                              controller.userName.value != "" ? controller.userName.value : "USER",
                              style:  TextStyle(
                                fontSize:  AppSpacings.s30,
                                color: ThemeService.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: ListView(
                        //           // shrinkWrap: true,
                        //           physics: const NeverScrollableScrollPhysics(),
                        //           children: [
                        //             Obx(
                        //                   () => Expanded(
                        //                 child: Text(
                        //                   controller.userName.value != "" ? controller.userName.value : "Vendor",
                        //                   style:  TextStyle(
                        //                     fontSize:  AppSpacings.s30,
                        //                     color: ThemeService.primaryColor,
                        //                     fontWeight: FontWeight.w600,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Text(
                        //               "View Profile",
                        //               style: TextStyle(
                        //                   color: ThemeService.grayScalecon,
                        //                   fontSize: AppSpacings.s15
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       Icon(
                        //         Icons.arrow_forward_ios,
                        //         color: ThemeService.primaryColor.withOpacity(0.6),
                        //         size: AppSpacings.s20,
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  )
                  else
                  ///Vendor Login
                  Container(
                    height: AppSpacings.s200,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ThemeService.primaryColor.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                      border: Border(
                          bottom: BorderSide(
                              color: ThemeService.primaryColor.withOpacity(0.5),
                              width: AppSpacings.s3)),
                    ),
                    padding:EdgeInsets.only(top: AppSpacings.s45,right:AppSpacings.s20,left: AppSpacings.s20,bottom: AppSpacings.s20),
                    child: GestureDetector(
                      onTap: (){
                        Get.back();
                        Get.toNamed(Routes.vendorProfile);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: AppSpacings.s12),
                          CircleAvatar(
                            backgroundColor: ThemeService.primaryColor.withOpacity(0.6),
                            maxRadius: AppSpacings.s35,
                            child: Obx(
                                  () => Text(
                                controller.userName.value != "" ? controller.userName.value.characters.first.toUpperCase() : "V",
                                style: TextStyle(fontSize: AppSpacings.s30, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacings.s12),
                          Column(
                            mainAxisSize : MainAxisSize.min,
                            children: [
                              Obx(
                                    () => Text(
                                  controller.userName.value != "" ? controller.userName.value : "Vendor",
                                  style:  TextStyle(
                                    fontSize:  AppSpacings.s30,
                                    color: ThemeService.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "View Profile",
                                style: TextStyle(
                                    color: ThemeService.grayScalecon,
                                    fontSize: AppSpacings.s15
                                ),
                              )
                            ],
                          ),
                          // Expanded(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Column(
                          //         mainAxisSize : MainAxisSize.min,
                          //         children: [
                          //           Obx(
                          //                 () => Text(
                          //                   controller.userName.value != "" ? controller.userName.value : "Vendor",
                          //                   style:  TextStyle(
                          //                     fontSize:  AppSpacings.s30,
                          //                     color: ThemeService.primaryColor,
                          //                     fontWeight: FontWeight.w600,
                          //                   ),
                          //                 ),
                          //           ),
                          //           Text(
                          //             "View Profile",
                          //             style: TextStyle(
                          //               color: ThemeService.grayScalecon,
                          //               fontSize: AppSpacings.s15
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //       // Expanded(
                          //       //   child: Icon(
                          //       //       Icons.arrow_forward_ios,
                          //       //       color: ThemeService.primaryColor.withOpacity(0.6),
                          //       //       size: AppSpacings.s20,
                          //       //     ),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  // Divider(
                  //   color: ThemeService.primaryColor.withOpacity(0.4),
                  //   thickness: 5,
                  //   height: .005,
                  // ),
                  Expanded(
                      child:ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: AppSpacings.s5),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user1.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Register Vendor",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.registerVendor);
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/vendor_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Vendor List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.vendorList);
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/create_job.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Create Job",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.createJob);
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/job_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Job List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobList,arguments: "Job List");
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/bid_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Job Bid List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.bidList,arguments: "Job Bid List");
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "1")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/joballocation_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "Job Allocation List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobAllocationList,arguments: "Job Allocation List");
                            },
                          ),
                          if(controller.userTypeID.value == "1")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),

                          /// Vendor Login
                          if(controller.userTypeID.value == "2")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/job_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "My Job",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobList,arguments: "My Job");
                            },
                          ),
                          if(controller.userTypeID.value == "2")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "2")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/bid_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "My Bid",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.bidList,arguments: "My Bid");
                            },
                          ),
                          if(controller.userTypeID.value == "2")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          if(controller.userTypeID.value == "2")
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/joballocation_list.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: ThemeService.primaryColor.withOpacity(0.6),
                              size: AppSpacings.s20,
                            ),
                            title: Text(
                              "My Allocated Job",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobAllocationList,arguments: "My Allocated Job");
                            },
                          ),
                          if(controller.userTypeID.value == "2")
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ],
                      )
                  ),
                  Bounce(
                    duration: const Duration(milliseconds: 90),
                    onPressed: () async {
                      try {
                        log('log out Successfully');
                        await GetStorage().remove(Constants.userName);
                        await GetStorage().remove(Constants.password);
                        await GetStorage().remove(Constants.token);
                        Get.find<AuthController>().isAlreadyLogin.value = false;
                        await Get.offAllNamed(Routes.login);
                      } catch (e) {
                        print("error...$e");
                      }
                    },
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: AppSpacings.s30, vertical: AppSpacings.s10),
                      margin: EdgeInsets.fromLTRB(AppSpacings.s30, AppSpacings.s15, AppSpacings.s30, AppSpacings.s15),
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
                          AppSpacings.s10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/drawer_icon/log out.png",
                              height: AppSpacings.s30,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            SizedBox(width: AppSpacings.s15),
                            Text("Log Out",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
