import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/spacing.dart';


class ThemeService extends GetxService {
  ThemeService();
  static Color subTitle = const Color.fromRGBO(36, 37, 40, 1).withOpacity(0.3);
  static Color grayScale = const Color.fromARGB(255, 187, 186, 186);
  static Color grayScalecon = const Color.fromARGB(255, 116, 118, 124);
  static const Color liteGrey = Color(0xffF3F3F2);
  static const Color grey = Color(0xff999999);
  static const Color subTitleColor = Color(0xff9C9C9C);
  static const Color border = Color(0xffDCDCDC);
  static const Color disable = Color.fromARGB(255, 198, 195, 195);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color pendingColor = Color(0xFFF23F3F);
  static const Color completedColor = Color(0xFF23B416);
  static const Color popUpBgColor = Color(0xFFF8F8F8);

  static const MaterialColor primaryColor = MaterialColor(
    0xFF2763af,
    <int, Color>{
      50: Color(0xFF2763af),
      100: Color(0xFF2763af),
      200: Color(0xFFB0A4EE),
      300: Color(0xFF8E7FE8),
      400: Color(0xFF7263E2),
      500: Color(0xFF5249DC),
      600: Color(0xFF4644D5),
      700: Color(0xFF313CCC),
      800: Color(0xFF1636C4),
      900: Color(0xFF002BB6),
    },
  );
  static const MaterialColor textColor = MaterialColor(
    0xFF1D2145,
    <int, Color>{
      100: Color(0xFFC1C6D7),
      300: Color(0xFF747EA0),
      500: Color(0xFF3D4A7D),
      700: Color(0xFF2F3A69),
      900: Color(0xFF1D2145),
    },
  );

  // Locale getLocale() {
  //   String? locale = GetStorage().read<String>('language');
  //   if (locale == null || locale.isEmpty) {
  //     locale = 'en';
  //   }
  //   return Get.find<TranslationService>().fromStringToLocale(locale);
  // }

  ThemeData getLightTheme({double scaleFactor = 1}) {
    return ThemeData(
      primarySwatch: primaryColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      fontFamily: 'OpenSans',
      appBarTheme: AppBarTheme(
          color: liteGrey,
          elevation: 0,
          toolbarHeight: AppSpacings.s75,
          iconTheme: const IconThemeData(color: Colors.black)
          // titleTextStyle: TextStyle(
          //   fontSize: 20.0 * scaleFactor,
          //   fontWeight: FontWeight.w500,
          //   color: Colors.black,
          // ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          padding: const EdgeInsets.all(14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(14),
        ),
      ),
      brightness: Brightness.light,
      dividerColor: Colors.grey,
      focusColor: primaryColor.shade400,
      hintColor: textColor.shade100,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      textTheme: getTextTheme(scaleFactor: scaleFactor),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
      ),
    );
  }

  ThemeData getDarkTheme({double scaleFactor = 1}) {
    return ThemeData(
      primarySwatch: primaryColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      fontFamily: 'OpenSans',
      appBarTheme: AppBarTheme(
        color: liteGrey,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: AppSpacings.s75,
        // titleTextStyle: TextStyle(
        //   fontSize: 16.0 * scaleFactor,
        //   fontWeight: FontWeight.w500,
        //   color: Colors.black,
        // ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          padding: const EdgeInsets.all(14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(14),
        ),
      ),
      brightness: Brightness.light,
      dividerColor: Colors.grey,
      focusColor: primaryColor.shade400,
      hintColor: textColor.shade100,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      textTheme: getTextTheme(scaleFactor: scaleFactor),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
      ),
    );
  }

  ThemeMode getThemeMode() {
    String themeMode = GetStorage().read<String>('theme_mode') ?? '';
    switch (themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: primaryColor.withOpacity(0.8)),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark
              .copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: primaryColor,),
        );
        return ThemeMode.light;
    }
  }

  TextTheme getTextTheme({double scaleFactor = 1}) {
    return TextTheme(
        titleLarge: TextStyle(
          fontSize: 32.0 * scaleFactor,
          fontWeight: FontWeight.w600,
          color: black,
          fontFamily: 'OpenSans',
        ),
        headlineSmall: TextStyle(
          fontSize: 24.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        headlineMedium: TextStyle(
          fontSize: 16.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        displaySmall: TextStyle(
          fontSize: 18.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        displayMedium: TextStyle(
          fontSize: 18.0 * scaleFactor,
          fontWeight: FontWeight.normal,
          color: black,
          fontFamily: 'OpenSans',
        ),
        displayLarge: TextStyle(
          fontSize: 16.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        titleSmall: TextStyle(
          fontSize: 16.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        titleMedium: TextStyle(
          fontSize: 16.0 * scaleFactor,
          fontWeight: FontWeight.normal,
          color: black,
          fontFamily: 'OpenSans',
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0 * scaleFactor,
          fontWeight: FontWeight.w500,
          color: black,
          fontFamily: 'OpenSans',
        ),
        bodyLarge: TextStyle(
          fontSize: 14.0 * scaleFactor,
          fontWeight: FontWeight.normal,
          color: black,
          fontFamily: 'OpenSans',
        ),
        bodySmall: TextStyle(
          fontSize: 12.0 * scaleFactor,
          fontWeight: FontWeight.normal,
          color: black,
          fontFamily: 'OpenSans',
        ),
      );
  }
}
