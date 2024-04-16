import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/spacing.dart';
import 'package:mudara_steel_app/common/themeService.dart';

class Constants{
  static const String userName = 'userName';
  static const String name = 'Name';
  static const String token = 'token';
  static const String password = 'password';
  static const String userTypeID = 'userTypeID';
  static Future<bool> isInternetAvail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  getTextFiled(String lable, var txtController,
      {String? preFixFile,
        bool isEnable = true,
        int maxline = 1,
        TextInputType textInputType = TextInputType.text,
        var inputformat}) {
    return TextField(
      controller: txtController,
      enabled: isEnable,
      maxLines: maxline,
      keyboardType: textInputType,
      cursorColor:  ThemeService.primaryColor,
      style: const TextStyle(
        fontSize: 14,
      ),
      inputFormatters: inputformat,
      decoration: InputDecoration(
         filled: true,
        prefixIcon: preFixFile != null
            ? Container(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            preFixFile,
            height: 15,
            color: Colors.black87 ,
          ),
        )
            : null,
        fillColor: ThemeService.primaryColor.withOpacity(.1),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ThemeService.primaryColor ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color:  ThemeService.primaryColor ,width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ThemeService.primaryColor ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        labelText: lable,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        hintStyle: const TextStyle(color: ThemeService.primaryColor ),
      ),
    );
  }

  static InputDecoration getInputDecoration({
    String? labelText = '',
    String hintText = '',
    String? errorText,
    Widget? iconData,
    Color? fillColor,
    Widget? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    TextStyle? hintStyle,
    bool? removeBorder,
    double? borderRadius,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: hintStyle,
      prefixIcon: iconData,
      fillColor: fillColor,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.only(left: 12, bottom: 18,top: 01),
      border:InputBorder.none,
      //   removeBorder ?? false
      //     ? InputBorder.none
      //     : OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(borderRadius ?? 8),
      // ),
      suffixIcon: suffixIcon,
      suffix: suffix,
      prefix: prefix,
      errorText: errorText,
    );
  }

  static appBar(title){
    return AppBar(
      surfaceTintColor: ThemeService.white,
      backgroundColor: ThemeService.white,
      titleSpacing: -AppSpacings.s5,
      shadowColor: ThemeService.border,
      elevation: .5,
      title:Text(
        title,
        style: Get.textTheme.headlineLarge?.copyWith(
          color: ThemeService.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: AppSpacings.s30,
        ),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) =>  Bounce(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.all(AppSpacings.s20),
              child: Icon(Icons.arrow_back_rounded,
                color: ThemeService.primaryColor,
                size: AppSpacings.s40,
              )
            // Image.asset('assets/back_arrow.png',
            //   width: AppSpacings.s30,
            // ),
          ),
        ),),
    );
  }

  static appBar1(title){
    return AppBar(
      title:Text(
        title,
        style: Get.textTheme.headlineLarge?.copyWith(
          color: ThemeService.primaryColor,
          fontWeight: FontWeight.w600,
          fontSize: AppSpacings.s30,
        ),
      ),
      centerTitle: true,
      leading: SizedBox(),
      surfaceTintColor: ThemeService.white,
      backgroundColor: ThemeService.white,
      titleSpacing: -AppSpacings.s5,
      shadowColor: ThemeService.border,
      elevation: .5,
      // leading: Builder(
      //     builder: (context) => GestureDetector(
      //       onTap: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       child:Padding(
      //         padding: EdgeInsets.all(AppSpacings.s15),
      //         child: Image.asset('assets/menu_assets/menu.png'),
      //       ),
      //     )),
      actions: [
        Bounce(
          duration: const Duration(milliseconds: 100),
          onPressed: () {
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.all(AppSpacings.s20),
              child: Icon(Icons.arrow_back_rounded,
                color: ThemeService.primaryColor,
                size: AppSpacings.s40,
              )
            // Image.asset('assets/back_arrow.png',
            //   width: AppSpacings.s30,
            // ),
          ),
        ),
      ],
    );
  }
}