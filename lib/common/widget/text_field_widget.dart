// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../spacing.dart';
import '../themeService.dart';

class TextFieldWidget extends StatelessWidget {
  final autoValidateMode;

  final FocusNode? focusNode;

  final EdgeInsets? margin;

  const TextFieldWidget({
    Key? key,
    this.onSaved,
    this.margin,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.hintStyle,
    this.textAlign,
    this.suffix,
    this.controller,
    this.enabled,
    this.leftPadding,
    this.rightPadding,
    this.maxLength,
    this.textInputAction,
    this.padding,
    this.removeShadow,
    this.prefix,
    this.inputFormatter,
    this.autoValidateMode,
    this.onFieldSubmitted,
    this.onTab,
    this.focusNode,
    this.minLine,
    this.autoFocus,
    this.disableColor,
    this.borderColor,
    this.fillColor,
    this.inputFormatters,
    this.maxLines,
    this.removeBorder,
    this.borderRadius,
  }) : super(key: key);

  final TextInputAction? textInputAction;
  final bool? autoFocus;
  final int? maxLength;
  final int? minLine;
  final int? maxLines;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final bool? enabled;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefix;
  final double? leftPadding;
  final double? rightPadding;
  final EdgeInsets? padding;
  final bool? removeShadow;
  final TextInputFormatter? inputFormatter;
  final ValueChanged<String>? onFieldSubmitted;
  final Function()? onTab;
  final Color? disableColor;
  final Color? borderColor;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool? removeBorder;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(vertical: AppSpacings.s15, horizontal: 0.0),
      margin: margin ??
          EdgeInsets.only(
            left: leftPadding ?? AppSpacings.s20,
            right: rightPadding ?? AppSpacings.s20,
            // top: topMargin,
            // bottom: bottomMargin,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (labelText is String)
            Text(
              labelText ?? '',
              style: Get.textTheme.bodyLarge?.copyWith(
                fontSize: AppSpacings.s18,
                color: Get.theme.primaryColor,
              ),
              textAlign: textAlign ?? TextAlign.start,
            ).paddingOnly(bottom: AppSpacings.s5),
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              // color:ThemeService.grayScale.withOpacity(0.5),
              color:ThemeService.white,
              border:Border.all(color: removeBorder == false ? ThemeService.grayScale.withOpacity(.8): Colors.transparent),
            ),
            child: Center(
              child: TextFormField(
                autofocus: autoFocus ?? false,
                focusNode: focusNode,
                autovalidateMode: autoValidateMode,
                controller: controller,
                key: key,
                maxLines: keyboardType == TextInputType.multiline ? maxLines : 1,
                minLines: minLine,
                keyboardType: keyboardType ?? TextInputType.text,
                onSaved: onSaved,
                onChanged: onChanged,
                validator: validator,
                initialValue: initialValue,
                style: style ?? Get.textTheme.titleSmall,
                obscureText: obscureText ?? false,
                textAlign: textAlign ?? TextAlign.start,
                decoration: Constants.getInputDecoration(
                  hintText: hintText ?? '',
                  iconData: prefixIcon2(iconData),
                  suffixIcon: suffixIcon,
                  suffix: suffix,
                  errorText: errorText,
                  fillColor: fillColor,
                  prefix: prefix,
                  hintStyle: hintStyle ?? Get.textTheme.bodySmall?.copyWith(fontSize: AppSpacings.s18 ,color: ThemeService.grayScalecon),
                  removeBorder: removeBorder,
                  borderRadius: borderRadius,
                ),
                enabled: enabled,
                onTap: onTab,
                onFieldSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters ??
                    [
                      if (maxLength is int)
                        LengthLimitingTextInputFormatter(maxLength),
                      if (inputFormatter is TextInputFormatter) inputFormatter!,
                    ],
                textInputAction: textInputAction,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget? prefixIcon2(dynamic iconData) {
    if (iconData is IconData) {
      return Icon(iconData, color: Get.theme.focusColor)
          .marginOnly(right: AppSpacings.s14);
    }
    if (iconData is Widget) {
      return iconData;
    }
    return null;
  }

  BorderRadius get buildBorderRadius {
    bool isFirst = this.isFirst ?? false;
    bool isLast = this.isLast ?? false;
    if (isFirst && isLast) {
      return BorderRadius.all(Radius.circular(AppSpacings.s10));
    }
    if (isFirst) {
      return BorderRadius.vertical(top: Radius.circular(AppSpacings.s10));
    }
    if (isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(AppSpacings.s10));
    }
    if (!isFirst && !isLast) {
      return const BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(AppSpacings.s10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst!)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast!)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
