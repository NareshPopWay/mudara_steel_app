
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
                      "assets/menu.png",
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
                  // SizedBox(height: AppSpacings.s20),
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: ThemeService.primaryColor.withOpacity(0.1),
                        border: Border(
                            bottom: BorderSide(
                                color: ThemeService.primaryColor.withOpacity(0.1),
                                width: AppSpacings.s3)),
                      ),
                      child:ListView(
                        shrinkWrap: true,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: ThemeService.primaryColor.withOpacity(0.3),
                            maxRadius: AppSpacings.s40,
                            child: Obx(
                                  () => Text(
                                controller.userName.value != "" ? controller.userName.value.characters.first : "A",
                                style: TextStyle(fontSize: AppSpacings.s30, color: ThemeService.primaryColor,fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(height: AppSpacings.s12),
                          Obx(
                                () => Center(
                                  child: Text(
                                    controller.userName.value != "" ? controller.userName.value : "Admin",
                                    style:  TextStyle(
                                      fontSize: controller.userName.value.length <= 5 ? AppSpacings.s35 : AppSpacings.s20,
                                      color: ThemeService.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                          ),

                        ],
                      )),
                  Divider(
                    color: ThemeService.primaryColor.withOpacity(0.4),
                    thickness: 5,
                    height: 5,
                  ),
                  Expanded(
                      child:ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Register Vendor",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.registerVendor);
                            },
                          ),
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Vendor List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.vendorList);
                            },
                          ),
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Create Job",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.createJob);
                            },
                          ),
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Job List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobList);
                            },
                          ),
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Job Bid List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.bidList);
                            },
                          ),
                          Divider(
                            color:ThemeService.primaryColor.withOpacity(0.4),
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -AppSpacings.s5),
                            leading: Image.asset(
                              "assets/drawer_icon/add-user.png",
                              height: AppSpacings.s35,
                              color: ThemeService.primaryColor,
                              alignment: Alignment.center,
                            ),
                            // trailing: Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: ThemeService.primaryColor.withOpacity(0.6),
                            //   size: AppSpacings.s20,
                            // ),
                            title: Text(
                              "Job Allocation List",
                              style: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSpacings.s20,
                                fontWeight: FontWeight.w700,
                                color: ThemeService.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.jobAllocationList);
                            },
                          ),
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
                    duration: Duration(milliseconds: 90),
                    onPressed: () async {
                      try {
                        log('log out Successfully');
                        await GetStorage().remove(Constants.userName);
                        await GetStorage().remove(Constants.password);
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
                              offset: Offset(1.5,1.5),
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
