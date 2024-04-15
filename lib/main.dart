import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/responsive_layout_builder.dart';
import 'package:mudara_steel_app/common/scale_factors.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/routes/page_routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DartPluginRegistrant.ensureInitialized();
  // await Firebase.initializeApp();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: ThemeService.primaryColor,
  //     systemNavigationBarColor: ThemeService.primaryColor,
  //     systemNavigationBarDividerColor: ThemeService.primaryColor,
  //   ),
  // );
  await GetStorage.init();

  runApp(
    ResponsiveLayoutBuilder(
      small: (BuildContext context, Widget? child) => MyApp(
        lightTheme: Get.find<ThemeService>()
            .getLightTheme(scaleFactor: DeviceScaleFactors.smallScaleFactor),
        darkTheme: Get.find<ThemeService>()
            .getDarkTheme(scaleFactor: DeviceScaleFactors.smallScaleFactor),
      ),
      medium: (BuildContext context, Widget? child) => MyApp(
        lightTheme: Get.find<ThemeService>()
            .getLightTheme(scaleFactor: DeviceScaleFactors.mediumScaleFactor),
        darkTheme: Get.find<ThemeService>()
            .getDarkTheme(scaleFactor: DeviceScaleFactors.mediumScaleFactor),
      ),
      large: (BuildContext context, Widget? child) => MyApp(
        lightTheme: Get.find<ThemeService>()
            .getLightTheme(scaleFactor: DeviceScaleFactors.largeScaleFactor),
        darkTheme: Get.find<ThemeService>()
            .getDarkTheme(scaleFactor: DeviceScaleFactors.largeScaleFactor),
      ),
      xLarge: (BuildContext context, Widget? child) => MyApp(
        lightTheme: Get.find<ThemeService>()
            .getLightTheme(scaleFactor: DeviceScaleFactors.xLargeScaleFactor),
        darkTheme: Get.find<ThemeService>()
            .getDarkTheme(scaleFactor: DeviceScaleFactors.xLargeScaleFactor),
      ),
    ),
  );
  Get.lazyPut(() => ThemeService());
}

class MyApp extends StatelessWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({Key? key, required this.lightTheme, required this.darkTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Mudra Steel",
      initialRoute: PageRoutes.initial,
      getPages: PageRoutes.routes,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<ThemeService>().getThemeMode(),
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
