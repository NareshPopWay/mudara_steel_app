// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
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
        initState: (c) async {
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
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ThemeService.primaryColor.withOpacity(0.2),
              ),
              surfaceTintColor: ThemeService.primaryColor.withOpacity(0.1),
              backgroundColor: ThemeService.primaryColor.withOpacity(0.1),
              elevation: 0.0,
              title: controller.userTypeID.value == "1"
                  ? Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              ThemeService.primaryColor.withOpacity(0.6),
                          maxRadius: AppSpacings.s25,
                          child: Obx(
                            () => Text(
                              controller.userName.value != ""
                                  ? controller.userName.value.characters.first
                                      .toUpperCase()
                                  : "A",
                              style: TextStyle(
                                  fontSize: AppSpacings.s30,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacings.s8),
                        Obx(
                          () => Expanded(
                            child: Text(
                              controller.userName.value != ""
                                  ? controller.userName.value
                                  : getTranslated(context, 'Admin')!,
                              style: TextStyle(
                                fontSize: AppSpacings.s28,
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
                    )
                  : Tooltip(
                      message: getTranslated(context, 'Profile')!,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.vendorProfile);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  ThemeService.primaryColor.withOpacity(0.6),
                              maxRadius: AppSpacings.s22,
                              child: Obx(
                                () => Text(
                                  controller.userName.value != ""
                                      ? controller
                                          .userName.value.characters.first
                                          .toUpperCase()
                                      : "V",
                                  style: TextStyle(
                                      fontSize: AppSpacings.s30,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacings.s8),
                            Obx(
                              () => Expanded(
                                child: Text(
                                  controller.userName.value != ""
                                      ? controller.userName.value
                                      : getTranslated(context, 'Vendor')!,
                                  style: TextStyle(
                                    fontSize: AppSpacings.s25,
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
                      ),
                    ),
              // leading: Builder(
              //   builder: (context) => GestureDetector(
              //     onTap: () {
              //       Scaffold.of(context).openDrawer();
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Image.asset(
              //         "assets/menu1.png",
              //         height: AppSpacings.s30,
              //         alignment: Alignment.center,
              //       ),
              //     ),
              //   ),
              // ),
              actions: [
                Tooltip(
                  message: getTranslated(context, 'Log Out')!,
                  child: Bounce(
                    duration: const Duration(milliseconds: 90),
                    onPressed: () async {
                      showGeneralDialog(
                          transitionDuration: const Duration(milliseconds: 400),
                          barrierDismissible: false,
                          barrierLabel: '',
                          pageBuilder: (ctx, a1, a2) {
                            return Container();
                          },
                          context: context,
                          transitionBuilder: (ctx, a1, a2, child) {
                            var curve = Curves.easeInOut.transform(a1.value);
                            return Transform.scale(
                              scale: curve,
                              child: Opacity(
                                opacity: a1.value,
                                child: AlertDialog(
                                  elevation: 5,
                                  surfaceTintColor: ThemeService.white,
                                  shadowColor:
                                      ThemeService.primaryColor.withOpacity(.5),
                                  contentPadding: const EdgeInsets.all(5.0),
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: ThemeService.primaryColor,
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  // titlePadding: EdgeInsets.only(top: Get.height*0.02),
                                  title: Text(
                                    getTranslated(context, 'AreYouSure')!,
                                    style: Get.textTheme.headline1!.copyWith(
                                        color: ThemeService.primaryColor,
                                        fontSize: Get.width * .050,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width / 25.0,
                                        right: Get.width / 25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.width * 0.02,
                                        ),
                                        Text(
                                          getTranslated(context, 'DoYouWantToLogOut')!,
                                          style:
                                              Get.textTheme.bodyLarge!.copyWith(
                                            color: ThemeService.textColor,
                                            fontSize: Get.width * .040,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: Get.height * 0.025),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Bounce(
                                              duration: const Duration(
                                                  milliseconds: 100),
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: Container(
                                                width: Get.width * 0.2,
                                                padding: EdgeInsets.all(
                                                    Get.width * .02),
                                                decoration: BoxDecoration(
                                                  color:
                                                      ThemeService.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * .02),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    getTranslated(context, 'Close')!,
                                                    style: Get
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontSize:
                                                          Get.width * 0.040,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: ThemeService.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Get.width * .02),
                                            Bounce(
                                              duration: const Duration(
                                                  milliseconds: 100),
                                              onPressed: () async {
                                                try {
                                                  log('log out Successfully');
                                                  await GetStorage().remove(
                                                      Constants.userName);
                                                  await GetStorage().remove(
                                                      Constants.password);
                                                  await GetStorage()
                                                      .remove(Constants.token);
                                                  Get.find<AuthController>()
                                                      .isAlreadyLogin
                                                      .value = false;
                                                  await Get.offAllNamed(
                                                      Routes.login);
                                                } catch (e) {
                                                  print("error...$e");
                                                }
                                                ;
                                              },
                                              child: Container(
                                                width: Get.width * 0.3,
                                                padding: EdgeInsets.all(
                                                    Get.width * .02),
                                                decoration: BoxDecoration(
                                                  color:
                                                      ThemeService.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * .02),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    getTranslated(context, 'LogOut')!,
                                                    style: Get
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                      fontSize:
                                                          Get.width * 0.040,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                  ),
                                ),
                                //
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/drawer_icon/log out.png',
                        color: ThemeService.primaryColor,
                        width: AppSpacings.s35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Obx(
              () => Container(
                color: ThemeService.white,
                padding: EdgeInsets.only(
                  left: AppSpacings.s20,
                  right: AppSpacings.s20,
                ),
                child: Text(
                  "${getTranslated(context, 'Version')!} : ${controller.appVersion.value}",
                  style: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSpacings.s20,
                    fontWeight: FontWeight.w700,
                    color: ThemeService.primaryColor.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: () {
                showGeneralDialog(
                    transitionDuration: const Duration(milliseconds: 400),
                    barrierDismissible: false,
                    barrierLabel: '',
                    pageBuilder: (ctx, a1, a2) {
                      return Container();
                    },
                    context: context,
                    transitionBuilder: (ctx, a1, a2, child) {
                      var curve = Curves.easeInOut.transform(a1.value);
                      return Transform.scale(
                        scale: curve,
                        child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            elevation: 5,
                            surfaceTintColor: ThemeService.white,
                            shadowColor:
                                ThemeService.primaryColor.withOpacity(.5),
                            contentPadding: const EdgeInsets.all(5.0),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: ThemeService.primaryColor,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            titlePadding: EdgeInsets.zero,
                            content: Padding(
                              padding: EdgeInsets.only(
                                  left: Get.width / 25.0,
                                  right: Get.width / 25.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.width * 0.05,
                                  ),
                                  Text(
                                    getTranslated(context, 'DoYouWantToExitTheApp')!,
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
                                        duration:
                                            const Duration(milliseconds: 100),
                                        onPressed: () async {
                                          Get.back();
                                        },
                                        child: Container(
                                          width: AppSpacings.s90,
                                          padding:
                                              EdgeInsets.all(AppSpacings.s8),
                                          decoration: BoxDecoration(
                                            color: ThemeService.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                AppSpacings.s15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              getTranslated(context, 'Cancel')!,
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(
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
                                        duration:
                                            const Duration(milliseconds: 100),
                                        onPressed: () async {
                                          await SystemNavigator.pop();
                                        },
                                        child: Container(
                                          width: AppSpacings.s110,
                                          padding:
                                              EdgeInsets.all(AppSpacings.s8),
                                          decoration: BoxDecoration(
                                            color: ThemeService.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                                AppSpacings.s15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              getTranslated(context, 'Exit')!,
                                              style: Get.textTheme.bodyLarge!
                                                  .copyWith(
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
                            ),
                          ),
                        ),
                      );
                    });

                return Future.value(true);
              },
              child: ListView(
                children: [
                  if (controller.userTypeID.value == "1")
                    AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: AppSpacings.s20,
                            right: AppSpacings.s20,
                            top: AppSpacings.s40,
                            bottom: AppSpacings.s10),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacings.s12,
                          mainAxisSpacing: AppSpacings.s15,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.adminBlocks.length,
                        itemBuilder: (context, index) => Obx(() =>
                            AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: controller.adminBlocks.length,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Bounce(
                                    duration: const Duration(milliseconds: 100),
                                    onPressed: () {
                                      if (index == 0) {
                                        Get.toNamed(Routes.registerVendor);
                                      } else if (index == 1) {
                                        Get.toNamed(Routes.vendorList);
                                      } else if (index == 2) {
                                        Get.toNamed(Routes.createJob);
                                      } else if (index == 3) {
                                        Get.toNamed(Routes.jobList);
                                      } else if (index == 4) {
                                        Get.toNamed(Routes.bidList);
                                      } else if (index == 5) {
                                        Get.toNamed(Routes.jobAllocationList);
                                      }
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: ThemeService.primaryColor
                                              .withOpacity(0.5),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            AppSpacings.s25),
                                      ),
                                      elevation: 0,
                                      clipBehavior: Clip.none,
                                      child: Container(
                                        height: AppSpacings.s300,
                                        decoration: BoxDecoration(
                                          color: ThemeService.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              AppSpacings.s25),
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      AppSpacings.s15),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppSpacings.s2),
                                                    child: Image.asset('${controller.adminBlocks.value[index].imgUrl}'),
                                                    // CachedNetworkImage(
                                                    //   imageUrl: AppConstants.imageUrl ?? "",
                                                    //   height: AppSpacings.s200,
                                                    //   width: AppSpacings.s200,
                                                    //   fit: BoxFit.cover,
                                                    //   placeholder: (context, url) => SizedBox(
                                                    //     // height: AppSpacings.s100,
                                                    //     child: Shimmer.fromColors(
                                                    //       baseColor: Colors.grey.shade300,
                                                    //       highlightColor: Colors.grey.shade100,
                                                    //       direction: ShimmerDirection.ltr,
                                                    //       child: Container(
                                                    //         color: Colors.white,
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    //   errorWidget: (context, url, error) => SizedBox(
                                                    //       child: Image.asset(
                                                    //           '${controller.posts.value[index].imgUrl}')
                                                    //       // Shimmer.fromColors(
                                                    //       //   baseColor: Colors.grey.shade300,
                                                    //       //   highlightColor: Colors.grey.shade100,
                                                    //       //   direction: ShimmerDirection.ltr,
                                                    //       //   child: Container(
                                                    //       //     color: Colors.white,
                                                    //       //   ),
                                                    //       // ),
                                                    //       ),
                                                    // ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.white,
                                                height: AppSpacings.s60,
                                                padding: EdgeInsets.only(
                                                    left: AppSpacings.s10,
                                                    right: AppSpacings.s10),
                                                child: Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    getTranslated(context, '${controller.adminBlocks.value[index].title}')!,
                                                    style: Get
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                      color: ThemeService
                                                          .primaryColor,
                                                      fontSize: AppSpacings.s18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    )
                  else
                    AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: AppSpacings.s20,
                            right: AppSpacings.s20,
                            top: AppSpacings.s40,
                            bottom: AppSpacings.s10),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacings.s12,
                          mainAxisSpacing: AppSpacings.s15,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.vendorBlock.value.length,
                        itemBuilder: (context, index) => Obx(() =>
                            AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: controller.adminBlocks.length,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                    child: Bounce(
                                  duration: const Duration(milliseconds: 100),
                                  onPressed: () {
                                    if (index == 0) {
                                      Get.toNamed(Routes.myJob);
                                    } else if (index == 1) {
                                      Get.toNamed(Routes.myBid);
                                    } else if (index == 2) {
                                      Get.toNamed(Routes.myAllocatedJob);
                                    }
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: ThemeService.primaryColor
                                            .withOpacity(0.5),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          AppSpacings.s25),
                                    ),
                                    elevation: 0,
                                    clipBehavior: Clip.none,
                                    child: Container(
                                      height: AppSpacings.s300,
                                      decoration: BoxDecoration(
                                        color: ThemeService.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                            AppSpacings.s25),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    AppSpacings.s15),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSpacings.s2),
                                                  child: Image.asset(
                                                      '${controller.vendorBlock.value[index].imgUrl}'),
                                                  // CachedNetworkImage(
                                                  //   imageUrl: AppConstants.imageUrl ?? "",
                                                  //   height: AppSpacings.s200,
                                                  //   width: AppSpacings.s200,
                                                  //   fit: BoxFit.cover,
                                                  //   placeholder: (context, url) => SizedBox(
                                                  //     // height: AppSpacings.s100,
                                                  //     child: Shimmer.fromColors(
                                                  //       baseColor: Colors.grey.shade300,
                                                  //       highlightColor: Colors.grey.shade100,
                                                  //       direction: ShimmerDirection.ltr,
                                                  //       child: Container(
                                                  //         color: Colors.white,
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  //   errorWidget: (context, url, error) => SizedBox(
                                                  //       child: Image.asset(
                                                  //           '${controller.posts.value[index].imgUrl}')
                                                  //       // Shimmer.fromColors(
                                                  //       //   baseColor: Colors.grey.shade300,
                                                  //       //   highlightColor: Colors.grey.shade100,
                                                  //       //   direction: ShimmerDirection.ltr,
                                                  //       //   child: Container(
                                                  //       //     color: Colors.white,
                                                  //       //   ),
                                                  //       // ),
                                                  //       ),
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: AppSpacings.s60,
                                              padding: EdgeInsets.only(
                                                  left: AppSpacings.s10,
                                                  right: AppSpacings.s10),
                                              child: Center(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  getTranslated(context, '${controller.vendorBlock.value[index].title}')!,
                                                  style: Get
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    color: ThemeService
                                                        .primaryColor,
                                                    fontSize: AppSpacings.s18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                )),
                              ),
                            )),
                      ),
                    ),
                ],
              ),
            ),
            // drawer: Drawer(
            //   backgroundColor: ThemeService.white,
            //   surfaceTintColor: ThemeService.white,
            //   elevation: 5,
            //   shadowColor: Colors.white,
            //   width: AppSpacings.s350,
            //   child: Column(
            //     children: [
            //       if(controller.userTypeID.value == "1")
            //       ///Admin Login
            //       Container(
            //         height: AppSpacings.s200,
            //         width: Get.width,
            //         decoration: BoxDecoration(
            //           color: ThemeService.primaryColor.withOpacity(0.1),
            //           borderRadius: const BorderRadius.only(
            //               bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
            //           border: Border(
            //               bottom: BorderSide(
            //                   color: ThemeService.primaryColor.withOpacity(0.5),
            //                   width: AppSpacings.s3)),
            //         ),
            //         padding:EdgeInsets.only(top: AppSpacings.s45,right:AppSpacings.s20,left: AppSpacings.s20,bottom: AppSpacings.s20),
            //         child: Row(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             SizedBox(width: AppSpacings.s12),
            //             CircleAvatar(
            //               backgroundColor: ThemeService.primaryColor.withOpacity(0.6),
            //               maxRadius: AppSpacings.s35,
            //               child: Obx(
            //                     () => Text(
            //                   controller.userName.value != "" ? controller.userName.value.characters.first.toUpperCase() : "U",
            //                   style: TextStyle(fontSize: AppSpacings.s30, color: Colors.white),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(width: AppSpacings.s12),
            //             Obx(
            //                   () => Expanded(
            //                 child: Text(
            //                   controller.userName.value != "" ? controller.userName.value : "USER",
            //                   style:  TextStyle(
            //                     fontSize:  AppSpacings.s30,
            //                     color: ThemeService.primaryColor,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             // Flexible(
            //             //   child: Row(
            //             //     children: [
            //             //       Expanded(
            //             //         child: ListView(
            //             //           // shrinkWrap: true,
            //             //           physics: const NeverScrollableScrollPhysics(),
            //             //           children: [
            //             //             Obx(
            //             //                   () => Expanded(
            //             //                 child: Text(
            //             //                   controller.userName.value != "" ? controller.userName.value : "Vendor",
            //             //                   style:  TextStyle(
            //             //                     fontSize:  AppSpacings.s30,
            //             //                     color: ThemeService.primaryColor,
            //             //                     fontWeight: FontWeight.w600,
            //             //                   ),
            //             //                 ),
            //             //               ),
            //             //             ),
            //             //             Text(
            //             //               "View Profile",
            //             //               style: TextStyle(
            //             //                   color: ThemeService.grayScalecon,
            //             //                   fontSize: AppSpacings.s15
            //             //               ),
            //             //             )
            //             //           ],
            //             //         ),
            //             //       ),
            //             //       Icon(
            //             //         Icons.arrow_forward_ios,
            //             //         color: ThemeService.primaryColor.withOpacity(0.6),
            //             //         size: AppSpacings.s20,
            //             //       ),
            //             //     ],
            //             //   ),
            //             // )
            //           ],
            //         ),
            //       )
            //       else
            //       ///Vendor Login
            //       Container(
            //         height: AppSpacings.s200,
            //         width: Get.width,
            //         decoration: BoxDecoration(
            //           color: ThemeService.primaryColor.withOpacity(0.1),
            //             borderRadius: const BorderRadius.only(
            //                 bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
            //           border: Border(
            //               bottom: BorderSide(
            //                   color: ThemeService.primaryColor.withOpacity(0.5),
            //                   width: AppSpacings.s3)),
            //         ),
            //         padding:EdgeInsets.only(top: AppSpacings.s45,right:AppSpacings.s20,left: AppSpacings.s20,bottom: AppSpacings.s20),
            //         child: GestureDetector(
            //           onTap: (){
            //             Get.back();
            //             Get.toNamed(Routes.vendorProfile);
            //           },
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               SizedBox(width: AppSpacings.s12),
            //               CircleAvatar(
            //                 backgroundColor: ThemeService.primaryColor.withOpacity(0.6),
            //                 maxRadius: AppSpacings.s35,
            //                 child: Obx(
            //                       () => Text(
            //                     controller.userName.value != "" ? controller.userName.value.characters.first.toUpperCase() : "V",
            //                     style: TextStyle(fontSize: AppSpacings.s30, color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(width: AppSpacings.s12),
            //               Column(
            //                 mainAxisSize : MainAxisSize.min,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Obx(() => Text(
            //                       controller.userName.value != "" ? controller.userName.value : "Vendor",
            //                       style:  TextStyle(
            //                         fontSize:  AppSpacings.s30,
            //                         color: ThemeService.primaryColor,
            //                         fontWeight: FontWeight.w600,
            //                       ),
            //                     ),
            //                   ),
            //                   Text(
            //                     "View Profile",
            //                     style: TextStyle(
            //                         color: ThemeService.grayScalecon,
            //                         fontSize: AppSpacings.s15
            //                     ),
            //                   )
            //                 ],
            //               ),
            //               // Expanded(
            //               //   child: Row(
            //               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               //     children: [
            //               //       Column(
            //               //         mainAxisSize : MainAxisSize.min,
            //               //         children: [
            //               //           Obx(
            //               //                 () => Text(
            //               //                   controller.userName.value != "" ? controller.userName.value : "Vendor",
            //               //                   style:  TextStyle(
            //               //                     fontSize:  AppSpacings.s30,
            //               //                     color: ThemeService.primaryColor,
            //               //                     fontWeight: FontWeight.w600,
            //               //                   ),
            //               //                 ),
            //               //           ),
            //               //           Text(
            //               //             "View Profile",
            //               //             style: TextStyle(
            //               //               color: ThemeService.grayScalecon,
            //               //               fontSize: AppSpacings.s15
            //               //             ),
            //               //           )
            //               //         ],
            //               //       ),
            //               //       // Expanded(
            //               //       //   child: Icon(
            //               //       //       Icons.arrow_forward_ios,
            //               //       //       color: ThemeService.primaryColor.withOpacity(0.6),
            //               //       //       size: AppSpacings.s20,
            //               //       //     ),
            //               //       // ),
            //               //     ],
            //               //   ),
            //               // ),
            //             ],
            //           ),
            //         ),
            //       ),
            //
            //       // Divider(
            //       //   color: ThemeService.primaryColor.withOpacity(0.4),
            //       //   thickness: 5,
            //       //   height: .005,
            //       // ),
            //       Expanded(
            //           child:ListView(
            //             padding: EdgeInsets.zero,
            //             physics: const BouncingScrollPhysics(),
            //             children: [
            //               SizedBox(height: AppSpacings.s5),
            //               if(controller.userTypeID.value == "1")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/add-user1.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "Register Vendor",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.registerVendor);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/vendor_list.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "Vendor",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.vendorList);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/create_job.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "Create Job",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.createJob);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/job_list.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "Job",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.jobList,arguments: "Job");
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "1")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               // if(controller.userTypeID.value == "1")
            //               // ListTile(
            //               //   dense: true,
            //               //   visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //               //   leading: Image.asset(
            //               //     "assets/drawer_icon/bid_list.png",
            //               //     height: AppSpacings.s35,
            //               //     color: ThemeService.primaryColor,
            //               //     alignment: Alignment.center,
            //               //   ),
            //               //   trailing: Icon(
            //               //     Icons.arrow_forward_ios,
            //               //     color: ThemeService.primaryColor.withOpacity(0.6),
            //               //     size: AppSpacings.s20,
            //               //   ),
            //               //   title: Text(
            //               //     "Job Bid",
            //               //     style: Get.textTheme.bodyLarge!.copyWith(
            //               //       fontSize: AppSpacings.s20,
            //               //       fontWeight: FontWeight.w500,
            //               //       color: ThemeService.primaryColor.withOpacity(0.7),
            //               //     ),
            //               //   ),
            //               //   onTap: () {
            //               //     Get.back();
            //               //     Get.toNamed(Routes.bidList,arguments: "Job Bid List");
            //               //   },
            //               // ),
            //               // if(controller.userTypeID.value == "1")
            //               // Divider(
            //               //   color:ThemeService.primaryColor.withOpacity(0.4),
            //               //   thickness: 1,
            //               //   indent: 10,
            //               //   endIndent: 10,
            //               // ),
            //               // if(controller.userTypeID.value == "1")
            //               //   ListTile(
            //               //     dense: true,
            //               //     visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //               //     leading: Image.asset(
            //               //       "assets/drawer_icon/create_job.png",
            //               //       height: AppSpacings.s35,
            //               //       color: ThemeService.primaryColor,
            //               //       alignment: Alignment.center,
            //               //     ),
            //               //     trailing: Icon(
            //               //       Icons.arrow_forward_ios,
            //               //       color: ThemeService.primaryColor.withOpacity(0.6),
            //               //       size: AppSpacings.s20,
            //               //     ),
            //               //     title: Text(
            //               //       "Create JobAllocation",
            //               //       style: Get.textTheme.bodyLarge!.copyWith(
            //               //         fontSize: AppSpacings.s20,
            //               //         fontWeight: FontWeight.w500,
            //               //         color: ThemeService.primaryColor.withOpacity(0.7),
            //               //       ),
            //               //     ),
            //               //     onTap: () {
            //               //       Get.back();
            //               //       Get.toNamed(Routes.createJobAllocation);
            //               //     },
            //               //   ),
            //               // if(controller.userTypeID.value == "1")
            //               //   Divider(
            //               //     color:ThemeService.primaryColor.withOpacity(0.4),
            //               //     thickness: 1,
            //               //     indent: 10,
            //               //     endIndent: 10,
            //               //   ),
            //               // if(controller.userTypeID.value == "1")
            //               // ListTile(
            //               //   dense: true,
            //               //   visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //               //   leading: Image.asset(
            //               //     "assets/drawer_icon/joballocation_list.png",
            //               //     height: AppSpacings.s35,
            //               //     color: ThemeService.primaryColor,
            //               //     alignment: Alignment.center,
            //               //   ),
            //               //   trailing: Icon(
            //               //     Icons.arrow_forward_ios,
            //               //     color: ThemeService.primaryColor.withOpacity(0.6),
            //               //     size: AppSpacings.s20,
            //               //   ),
            //               //   title: Text(
            //               //     "Job Allocation",
            //               //     style: Get.textTheme.bodyLarge!.copyWith(
            //               //       fontSize: AppSpacings.s20,
            //               //       fontWeight: FontWeight.w500,
            //               //       color: ThemeService.primaryColor.withOpacity(0.7),
            //               //     ),
            //               //   ),
            //               //   onTap: () {
            //               //     Get.back();
            //               //     Get.toNamed(Routes.jobAllocationList,arguments: "Job Allocation");
            //               //   },
            //               // ),
            //               // if(controller.userTypeID.value == "1")
            //               // Divider(
            //               //   color:ThemeService.primaryColor.withOpacity(0.4),
            //               //   thickness: 1,
            //               //   indent: 10,
            //               //   endIndent: 10,
            //               // ),
            //
            //               /// Vendor Login
            //               if(controller.userTypeID.value == "2")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/applyjob.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "Apply Job",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.applyJob);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/job_list.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "My Job",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.myJob);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/bid_list.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "My Bid",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.myBid);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               ListTile(
            //                 dense: true,
            //                 visualDensity: VisualDensity(vertical: -AppSpacings.s5),
            //                 leading: Image.asset(
            //                   "assets/drawer_icon/joballocation_list.png",
            //                   height: AppSpacings.s35,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 trailing: Icon(
            //                   Icons.arrow_forward_ios,
            //                   color: ThemeService.primaryColor.withOpacity(0.6),
            //                   size: AppSpacings.s20,
            //                 ),
            //                 title: Text(
            //                   "My Allocated Job",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w500,
            //                     color: ThemeService.primaryColor.withOpacity(0.7),
            //                   ),
            //                 ),
            //                 onTap: () {
            //                   Get.back();
            //                   Get.toNamed(Routes.myAllocatedJob);
            //                 },
            //               ),
            //               if(controller.userTypeID.value == "2")
            //               Divider(
            //                 color:ThemeService.primaryColor.withOpacity(0.4),
            //                 thickness: 1,
            //                 indent: 10,
            //                 endIndent: 10,
            //               ),
            //             ],
            //           )
            //       ),
            //       Bounce(
            //         duration: const Duration(milliseconds: 90),
            //         onPressed: () async {
            //           try {
            //             log('log out Successfully');
            //             await GetStorage().remove(Constants.userName);
            //             await GetStorage().remove(Constants.password);
            //             await GetStorage().remove(Constants.token);
            //             Get.find<AuthController>().isAlreadyLogin.value = false;
            //             await Get.offAllNamed(Routes.login);
            //           } catch (e) {
            //             print("error...$e");
            //           }
            //         },
            //         child: Container(
            //           // padding: EdgeInsets.symmetric(horizontal: AppSpacings.s30, vertical: AppSpacings.s10),
            //           margin: EdgeInsets.fromLTRB(AppSpacings.s30, AppSpacings.s15, AppSpacings.s30, AppSpacings.s15),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(25),
            //             color: ThemeService.white,
            //             boxShadow:  [
            //               BoxShadow(
            //                   color: ThemeService.primaryColor.withOpacity(0.5),
            //                   blurRadius: 9.5,
            //                   blurStyle: BlurStyle.inner,
            //                   offset: const Offset(1.5,1.5),
            //                   spreadRadius: 1.5
            //               )
            //             ],
            //             border: Border.all(color: ThemeService.primaryColor.withOpacity(0.8)),
            //           ),
            //           child: Padding(
            //             padding: EdgeInsets.all(
            //               AppSpacings.s10,
            //             ),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Image.asset(
            //                   "assets/drawer_icon/log out.png",
            //                   height: AppSpacings.s30,
            //                   color: ThemeService.primaryColor,
            //                   alignment: Alignment.center,
            //                 ),
            //                 SizedBox(width: AppSpacings.s15),
            //                 Text("Log Out",
            //                   style: Get.textTheme.bodyLarge!.copyWith(
            //                     fontSize: AppSpacings.s20,
            //                     fontWeight: FontWeight.w700,
            //                     color: ThemeService.primaryColor.withOpacity(0.8),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          );
        });
  }
}
