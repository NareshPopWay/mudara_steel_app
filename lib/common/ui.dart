import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/spacing.dart';


class Ui {


  static SuccessSnackBar({String title = 'Success', String? message}) {
    Get.log("[$title] $message");
    return Future.delayed(Duration.zero).then(
          (value) => Get.showSnackbar(
        GetSnackBar(
          titleText: Text(
            title.tr,
            style: Get.textTheme.headlineSmall?.merge(
              TextStyle(
                  color: const Color(0xFF32BC32),
                  fontWeight: FontWeight.w700,
                  fontSize: AppSpacings.s22
              ),
            ),
          ),
          messageText: Text(
            message ?? '',
            style: Get.textTheme.subtitle2?.merge(
              TextStyle(
                  color: const Color(0xFF32BC32),
                  fontWeight: FontWeight.w600,
                  fontSize: AppSpacings.s18
              ),
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(AppSpacings.s20),
          backgroundColor: const Color(0xFFC9F9C1),
          icon: Icon(
            Icons.check_circle_outline,
            size: AppSpacings.s32,
            color: const Color(0xFF32BC32),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacings.s20,
            vertical: AppSpacings.s18,
          ),
          borderRadius: AppSpacings.s20,
          borderColor: Colors.green,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 5),
        ),
      ),
    );
  }

  static Future ErrorSnackBar({String title = 'Error', String? message, Color? color, Color? textColor}) {
    Get.log("[$title] $message", isError: true);
    return Future.delayed(Duration.zero).then(
          (value) => Get.showSnackbar(
        GetSnackBar(
          titleText: Text(
            title.tr,
            style: Get.textTheme.headlineSmall?.merge(
              TextStyle(
                  color:const Color(0xFFD8000C),
                  fontWeight: FontWeight.w700,
                  fontSize: AppSpacings.s20
              ),
            ),
          ),
          messageText: Text(
            message ?? '',
            style: Get.textTheme.subtitle2?.merge(
              TextStyle(
                  color: const Color(0xFFD8000C),
                  fontWeight: FontWeight.w600,
                  fontSize: AppSpacings.s18
              ),
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          backgroundColor: const Color(0xFFFFBABA),
          icon: const Icon(
            Icons.error_outline_sharp,
            size: 32,
            color: Color(0xFFD8000C),
          ),
          borderRadius: AppSpacings.s20,
          borderColor: const Color(0xFFD8000C),
          duration: const Duration(seconds: 5),
        ),
      ),
    );
  }

  static Future worningSnackBar({String title = 'Error', String? message,double fontSize = 18.0}) {
    Get.log("[$title] $message", isError: true);
    return Future.delayed(Duration.zero).then(
          (value) => Get.showSnackbar(
        GetSnackBar(
          titleText: Text(
            title.tr,
            style: Get.textTheme.headlineSmall?.merge(
              TextStyle(
                  color:const Color(0xFF9F6000),
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize
              ),
            ),
          ),
          messageText: Text(
            message ?? '',
            style: Get.textTheme.subtitle2?.merge(
              const TextStyle(
                color: Color(0xFF9F6000),
              ),
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          backgroundColor: const Color(0xFFFEEFB3),
          icon: const Icon(
            Icons.error_outline_sharp,
            size: 32,
            color: Color(0xFF9F6000),
          ),
          borderRadius: AppSpacings.s20,
          borderColor: const Color(0xFF9F6000),
          duration: const Duration(seconds: 5),
        ),
      ),
    );
  }

  static Future ActionSnackBar({String title = 'Error', String? message}) {
    Get.log("[$title] $message", isError: true);
    return Future.delayed(Duration.zero).then(
          (value) => Get.showSnackbar(
        GetSnackBar(
          titleText: Text(
            title.tr,
            style: Get.textTheme.headline4?.merge(TextStyle(color: Get.theme.cardColor)),
          ),
          messageText: Text(
            message ?? '',
            style: Get.textTheme.caption?.merge(TextStyle(color: Get.theme.cardColor)),
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          backgroundColor: Colors.redAccent,
          icon: Icon(
            Icons.remove_circle_outline,
            size: 32,
            color: Get.theme.cardColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          borderRadius: 8,
          duration: const Duration(seconds: 5),
        ),
      ),
    );
  }

  static GetSnackBar defaultSnackBar({
    String title = 'Alert',
    String? message,
    Widget? actionButton,
    OnTap? onTap,
  }) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.headline6?.merge(TextStyle(color: Get.theme.hintColor)),
      ),
      messageText: Text(
        message ?? '',
        style: Get.textTheme.caption?.merge(TextStyle(color: Get.theme.focusColor)),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.cardColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(
        Icons.warning_amber_rounded,
        size: 32,
        color: Get.theme.hintColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
      mainButton: actionButton,
      onTap: onTap,
    );
  }

  static GetSnackBar notificationSnackBar({
    String title = 'Notification',
    String? message,
    Function(GetSnackBar snack)? onTap,
  }) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(
        title.tr,
        style: Get.textTheme.headline6?.merge(TextStyle(color: Get.theme.hintColor)),
      ),
      messageText: Text(
        message ?? '',
        style: Get.textTheme.caption?.merge(TextStyle(color: Get.theme.focusColor)),
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: Get.theme.cardColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.notifications_none, size: 32, color: Get.theme.hintColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
    );
  }

  // static Color parseColor(String hexCode, {double? opacity}) {
  //   try {
  //     return Color(int.parse(hexCode.replaceAll("#", "0xFF"))).withOpacity(opacity ?? 1);
  //   } catch (e) {
  //     Get.log(
  //       CustomTrace(StackTrace.current, message: e.toString()).toString(),
  //     );
  //     return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
  //   }
  // }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: const Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(
        Icon(Icons.star_half, size: size, color: const Color(0xFFFFB24D)),
      );
    }
    list.addAll(
      List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
        return Icon(
          Icons.star_border,
          size: size,
          color: const Color(0xFFFFB24D),
        );
      }),
    );
    return list;
  }

  static BoxDecoration getBoxDecoration({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    double? radius,
    Border? border,
    Gradient? gradient,
    BoxShape? shape,
    num? elevation,
  }) {
    BorderRadiusGeometry borderRadiusBox = BorderRadius.all(Radius.circular(radius ?? 10));
    if (borderRadius is BorderRadiusGeometry) {
      borderRadiusBox = borderRadius;
    }
    return BoxDecoration(
      color: color ?? Get.theme.cardColor,
      borderRadius: shape == null ? borderRadiusBox : null,
      shape: shape ?? BoxShape.rectangle,
      boxShadow: [
        if (elevation != 0)
          BoxShadow(
            color: Get.theme.focusColor.withOpacity(0.1),
            blurRadius: elevation?.toDouble() ?? 10,
            offset: const Offset(0, 5),
          ),
      ],
      border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration({
    String? labelText = '',
    String hintText = '',
    String? errorText,
    Widget? iconData,
    Widget? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    bool? removeBorder,
  }) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Get.textTheme.caption?.copyWith(fontSize: AppSpacings.s16),
      prefixIcon: iconData,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: removeBorder ?? false
          ? InputBorder.none
          : OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      suffixIcon: suffixIcon,
      suffix: suffix,
      prefix: prefix,
      errorText: errorText,
    );
  }

  static Future showSuccessBottomSheet(
      String action, {
        bool showGetBack = true,
        bool showDoneText = true,
      }) async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      elevation: 10.0,
      enableDrag: false,
      useRootNavigator: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: Get.height * 0.5,
          child: WillPopScope(
            onWillPop: () async => true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: Image.asset(
                    'assets/transparent_pattern.png',
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: Get.height,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 5,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Image.asset(
                          "assets/done.gif",
                          gaplessPlayback: false,
                          repeat: ImageRepeat.noRepeat,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        showDoneText == true ? '$action Done' : action,
                        style: Get.textTheme.headline5,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    if (showGetBack) {
      await Future.delayed(const Duration(seconds: 4)).then((value) {
        Get.back();
      });
    }
  }
}
