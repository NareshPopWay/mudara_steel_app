// ignore_for_file: unnecessary_null_comparison, prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/model/admin_block_model.dart';
import 'package:package_info_plus/package_info_plus.dart';


class WebHomeController extends GetxController with GetTickerProviderStateMixin {


  AnimationController? animationController;
  Animation<double>? animation;
  @override
  void onInit() async {
    super.onInit();
    // posts.bindStream(FirebaseService().getPost());
    // treatments.bindStream(FirebaseService().getTreatments());
    // products.bindStream(FirebaseService().getProducts());
    animationController =  AnimationController(vsync: this,duration: const Duration(milliseconds: 8000))..addListener(() {update();})..repeat();
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

  }

  RxList factoryImages = [
    'assets/home/factory/factory-1.jpg',
    'assets/home/factory/factory-2.jpg',
    'assets/home/factory/factory-3.jpg',
    'assets/home/factory/factory-4.jpg',
  ].obs;

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   animationController!.dispose();
  // }

}
