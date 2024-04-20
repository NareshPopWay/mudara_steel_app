import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../spacing.dart';
import '../themeService.dart';

leadCard(int index, List<Widget> items) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSpacings.s10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        width: 1,
        color: ThemeService.primaryColor.shade50,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

headerRow({String? title1, Icon? icon1,}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    // decoration: BoxDecoration(
    //   borderRadius: const BorderRadius.only(
    //     topRight: Radius.circular(20),
    //     topLeft: Radius.circular(20),
    //   ),
    //   // color: ThemeService.primaryColor.withOpacity(0.2),
    // ),
    height: AppSpacings.s50,
    child: Row(
      children: [
        icon1 ?? const SizedBox(),
        Text(
          title1 ?? "",
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.displayMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: AppSpacings.s20,
          ),
        ),
      ],
    ),
  );
}
headerRow1({String? title1, Icon? icon1, String? title2, Icon? icon2, bool? isSingle,VoidCallback? onTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    // decoration: BoxDecoration(
    //   borderRadius: const BorderRadius.only(
    //     topRight: Radius.circular(20),
    //     topLeft: Radius.circular(20),
    //   ),
    //   color: ThemeService.primaryColor.withOpacity(0.2),
    // ),
    height: AppSpacings.s50,
    child: Row(
      mainAxisAlignment: isSingle == true ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
      children: [
        if (isSingle == true) SizedBox(width: AppSpacings.s14),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            icon1 ?? const SizedBox(),
            if (icon1 != null) const SizedBox(width: 5),
            SizedBox(
              width: isSingle == true ? Get.width * .8 : Get.width / 3,
              child: Text(
                title1 ?? "",
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.displayMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: AppSpacings.s20,
                ),
              ),
            ),
          ],
        ),
        if (isSingle != true)
          Container(
            color: ThemeService.primaryColor.withOpacity(0.2),
            width: 1,
            height: AppSpacings.s30,
          ),
        if (isSingle != true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // icon2 ?? const SizedBox(),
              if (icon2 != null) const SizedBox(width: 5),
              GestureDetector(
                onTap:onTap,
                child: SizedBox(
                  width: Get.width / 3,
                  child: Text(
                    title2 ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSpacings.s20,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    ),
  );
}

header({String? title, String? value, Color? color = Colors.black}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    // decoration: BoxDecoration(
    //   // borderRadius: const BorderRadius.only(
    //   //   topRight: Radius.circular(20),
    //   //   topLeft: Radius.circular(20),
    //   // ),
    //   color: ThemeService.primaryColor.withOpacity(0.2),
    // ),
    height: AppSpacings.s50,
    child: Row(
      children: [
         SizedBox(width: AppSpacings.s10),
        Expanded(
          child: Text(
            "${title ?? ''} ${title == null && value == null ? '' : ' : '} ${value ?? ''}",
            style: Get.textTheme.displayMedium!.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: AppSpacings.s18,
            ),
          ),
        ),
      ],
    ),
  );
}

dataRow({String? title1, String? value1, String? title2, String? value2, Color? titleColor1, Color? valueColor1,Color? titleColor2, Color? valueColor2, bool? isSingle = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dataColumn(title: title1, value: value1,titleColor: titleColor1,valueColor: valueColor1),
        if (isSingle != true) dataColumn(title: title2, value: value2,valueColor: valueColor2,titleColor:titleColor2),
      ],
    ),
  );
}

dataColumn({String? title, String? value, Color? titleColor, Color? valueColor,}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: Get.textTheme.bodyText2!.copyWith(
            color: titleColor ?? ThemeService.disable,
            fontSize: AppSpacings.s15,
          ),
        ),
        Text(
          value ?? "",
          style: Get.textTheme.headline4!.copyWith(
            fontSize: AppSpacings.s18,
            color: valueColor ?? ThemeService.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

dataWithButtonRow({String? title, String? value, OnTap? onTap, String? btnName}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: AppSpacings.s14, vertical: AppSpacings.s10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dataColumn(title: title, value: value),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppSpacings.s22, vertical: AppSpacings.s8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeService.disable,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  btnName ?? "Action",
                  style: Get.textTheme.headlineLarge!.copyWith(
                    color: ThemeService.primaryColor,
                    fontSize: AppSpacings.s20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: AppSpacings.s6),
                Icon(
                  Icons.arrow_forward,
                  color: ThemeService.primaryColor,
                  size: AppSpacings.s20,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
