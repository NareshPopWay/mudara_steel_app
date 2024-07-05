// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'dart:io' as io;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/controllers/root_controller.dart';
import 'package:mudara_steel_app/controllers/web_home_controller.dart';
import 'dart:math' as math;

import 'package:mudara_steel_app/routes/app_routes.dart';

class WebHomeScreen extends GetView<WebHomeController> {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebHomeController>(
        init: WebHomeController(),
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
            body: ListView(
              shrinkWrap: true,
              children: [
                Image.asset('assets/home/main-banner_OLD.jpg'),
                Padding(
                  padding: EdgeInsets.only(top: AppSpacings.s20,left: AppSpacings.s20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Transform(
                            transform: Matrix4.identity()..rotateZ((controller.animation!.value) * math.pi * 2),
                            alignment: FractionalOffset.center,
                            child: Image.asset('assets/home/text-circle.png',
                             scale: 1.6),
                          ),
                          Image.asset('assets/home/icon.png', scale: 1.6),
                        ],
                      ),
                      SizedBox(width: AppSpacings.s20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            softWrap: true,
                            text:TextSpan(
                                text: 'EMPOWERING STRUCTURES WITH A LEGACY OF',
                                style: Get.textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff383e88),
                                  fontSize: AppSpacings.s24,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' STRENGTH.',
                                    style: Get.textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffef6a01),
                                      fontSize: AppSpacings.s24,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('assets/home/about.jpg',scale: 1.2),
                      SizedBox(height: AppSpacings.s20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'At MUDRA STEEL, we pride ourselves on being at the forefront of the steel TMT (Thermo-Mechanically Treated) bar manufacturing industry.',
                          style: Get.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ThemeService.grey,
                            fontSize: AppSpacings.s16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Since our inception, we have been dedicated to producing high-quality TMT bars that exceed industry standards. Our state-of-the-art manufacturing facilities are equipped with the latest technology and operated by a team of skilled professionals who ensure precision at every stage of production.',
                          style: Get.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ThemeService.grey,
                            fontSize: AppSpacings.s16,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacings.s20),
                      Image.asset('assets/home/about-2.jpg',scale: 1.2),
                      SizedBox(height: AppSpacings.s10),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xffF2F3F5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'EXPLORE THE INNOVATION BEHIND OUR STEEL BARS!',
                          style: Get.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff383e88),
                            fontSize: AppSpacings.s24,
                          ),
                        ),
                        SizedBox(height: AppSpacings.s15),
                        Container(
                          decoration: const BoxDecoration(
                            color: ThemeService.white,
                          ),
                          padding: EdgeInsets.all(AppSpacings.s15),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/home/house.png',width: AppSpacings.s35,color: const Color(0xffef6a01),),
                                  SizedBox(width: AppSpacings.s8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('35,000 SQ. METER',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff383e88),
                                          fontSize: AppSpacings.s18,
                                        ),
                                      ),
                                      SizedBox(height: AppSpacings.s10),
                                      Text('Steel Plant',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          color: Colors.grey,
                                          fontSize: AppSpacings.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: AppSpacings.s10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/home/worker.png',width: AppSpacings.s35,color: const Color(0xffef6a01),),
                                  SizedBox(width: AppSpacings.s8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('500 EMPLOYEES',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff383e88),
                                          fontSize: AppSpacings.s18,
                                        ),
                                      ),
                                      SizedBox(height: AppSpacings.s10),
                                      Text('Work force',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          color: Colors.grey,
                                          fontSize: AppSpacings.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSpacings.s15),
                        Container(
                          decoration: const BoxDecoration(
                            color: ThemeService.white,
                          ),
                          padding: EdgeInsets.all(AppSpacings.s15),
                          child: Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/home/upgrade.png',width: AppSpacings.s35,color: const Color(0xffef6a01),),
                                  SizedBox(width: AppSpacings.s8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('150,000 METRIC \nTONNES',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff383e88),
                                          fontSize: AppSpacings.s18,
                                        ),
                                      ),
                                      SizedBox(height: AppSpacings.s10),
                                      Text('Annual Capacity',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          color: Colors.grey,
                                          fontSize: AppSpacings.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: AppSpacings.s10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('assets/home/award.png',width: AppSpacings.s35,color: const Color(0xffef6a01),),
                                  SizedBox(width: AppSpacings.s8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('SUSTAINABILITY \n& RESPONSIBLE',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff383e88),
                                          fontSize: AppSpacings.s18,
                                        ),
                                      ),
                                      SizedBox(height: AppSpacings.s10),
                                      Text('Recycling Practices',
                                        style: Get.textTheme.headlineSmall!.copyWith(
                                          color: Colors.grey,
                                          fontSize: AppSpacings.s16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppSpacings.s10),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffef6a01),
                  ),
                  padding: EdgeInsets.all(AppSpacings.s15),
                  child:Row(
                    children: [
                      Image.asset('assets/home/thermex-logo-white.png',width: AppSpacings.s130),
                      SizedBox(width: AppSpacings.s8),
                      Text(
                        'THERMEX TECHNOLOGY TMT BARS',
                        style: Get.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ThemeService.white,
                          fontSize: AppSpacings.s16,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: AppSpacings.s30),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow:  [
                              BoxShadow(
                                  color: ThemeService.black.withOpacity(0.3),
                                  blurRadius: 10.5,
                                  spreadRadius: 0.5
                              )
                            ]
                        ),
                        padding: EdgeInsets.all(AppSpacings.s25),
                        child: Image.asset('assets/logo.png',width: AppSpacings.s40)),
                    SizedBox(height: AppSpacings.s25),
                    Text(
                      'FACTORY GALLERY',
                      style: Get.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff383e88),
                        fontSize: AppSpacings.s25,
                      ),
                    ),
                    SizedBox(height: AppSpacings.s25),
                    CarouselSlider.builder(
                      itemCount: controller.factoryImages.length,
                      itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                          Image.asset('${controller.factoryImages[index]}'),
                      options: CarouselOptions(
                          autoPlay:  true,
                          viewportFraction: 0.6,
                          // aspectRatio: 2.0,
                          enableInfiniteScroll: true,
                      ),
                    ),
                    SizedBox(height: AppSpacings.s25),
                  ],
                ),
                Container(
                  color: const Color(0xffF2F3F5),
                  child: Padding(
                    padding:  EdgeInsets.all(AppSpacings.s50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text:TextSpan(
                              text: 'MUDRA TMT :\n',
                              style: Get.textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff383e88),
                                fontSize: AppSpacings.s24,
                              ),
                              children: [
                                TextSpan(
                                  text: 'THE ULTIMATE',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffCFCFCF),
                                    fontSize: AppSpacings.s24,
                                  ),
                                ),
                                TextSpan(
                                  text: ' CHOICE FOR \n',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffef6a01),
                                    fontSize: AppSpacings.s24,
                                  ),
                                ),
                                TextSpan(
                                  text: 'STRENGTH',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffef6a01),
                                    fontSize: AppSpacings.s24,
                                  ),
                                ),
                                TextSpan(
                                  text: ' & ',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff383e88),
                                    fontSize: AppSpacings.s24,
                                  ),
                                ),
                                TextSpan(
                                  text: 'FLEXIBILITY',
                                  style: Get.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffef6a01),
                                    fontSize: AppSpacings.s24,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: AppSpacings.s250,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                         fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image:AssetImage('assets/home/bg.jpg'))
                  ),
                  child: Container(
                    color: const Color(0xff383e88).withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/home/logo-white.png',width: AppSpacings.s80,),
                              Container(
                                width:AppSpacings.s120,
                                decoration: BoxDecoration(
                                    color: Color(0xffef6a01),
                                    borderRadius: BorderRadius.circular(AppSpacings.s10)
                                ),
                                child:Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: ()async{
                                      controller.animationController!.dispose();
                                      await Get.offAllNamed(Routes.login);
                                    },
                                    child: Padding(
                                      padding:EdgeInsets.all(AppSpacings.s15),
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: Get.textTheme.headlineSmall!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: ThemeService.white,
                                            fontSize: AppSpacings.s20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacings.s15),
                          Padding(
                            padding: EdgeInsets.all(AppSpacings.s20),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'If You want to work with us \nas vendor then register your self ',
                                    textAlign: TextAlign.center,
                                    style: Get.textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ThemeService.white,
                                      fontSize: AppSpacings.s22,
                                    ),
                                  ),
                                  SizedBox(height: AppSpacings.s15),
                                  Container(
                                    width:AppSpacings.s120,
                                    decoration: BoxDecoration(
                                      color: Color(0xffef6a01),
                                      borderRadius: BorderRadius.circular(AppSpacings.s10)
                                    ),
                                    child:Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: ()async{
                                          // controller.animationController!.dispose();
                                          Get.toNamed(Routes.vendorReg);
                                        },
                                        child: Padding(
                                          padding:EdgeInsets.all(AppSpacings.s15),
                                          child: Center(
                                            child: Text(
                                                'Register',
                                                style: Get.textTheme.headlineSmall!.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: ThemeService.white,
                                                  fontSize: AppSpacings.s20,
                                                ),
                                              ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
