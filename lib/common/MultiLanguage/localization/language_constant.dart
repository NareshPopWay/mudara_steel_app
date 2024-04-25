import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/demo_localization.dart';

const String LAGUAGE_CODE = 'languageCode';

///languages code

const String ENGLISH = 'en';

const String HINDI = 'hi';

/// To store and save the selected language according to the language code

Future<Locale> setLocale(String languageCode) async {
  await GetStorage().write(LAGUAGE_CODE, languageCode);

  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = GetStorage().read(LAGUAGE_CODE).toString() ?? "en";

  return _locale(languageCode);
}

// switch statements

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, 'US');
    case HINDI:
      return const Locale(HINDI, "IN");
    default:
      return const Locale(HINDI, 'IN');
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key);
}
