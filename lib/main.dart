import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/responsive_layout_builder.dart';
import 'package:mudara_steel_app/common/scale_factors.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';
import 'package:mudara_steel_app/routes/page_routes.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClientcreateHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  log("Handling a background message: ${message!.messageId}");
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log(message.data['screen']);
    if (message.data['screen'] == 'bidList') {
      Get.toNamed(Routes.applyJob,arguments: message.data['jobId']);
    }
  });
}

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

  FirebaseOptions options;
  if (Platform.isAndroid) {
    options = const FirebaseOptions(
        apiKey: "AIzaSyCMPMhF9ZSKrHtGj9L79p5JyIzbdAe4Md8",
        appId: "1:600149927142:android:5d700a946b003171644727",
        messagingSenderId: "600149927142",
        projectId: "mudrasteel-711c1");
  } else {
    options = const FirebaseOptions(
        apiKey: "AIzaSyA_Tc2htTkxcGWQVhLXRUxb2j1qssjV-QA",
        appId: "1:851415038414:ios:161a82264c21e3c7fb939f",
        messagingSenderId: "851415038414",
        projectId: "sakhiya-175a5");
  }
  await Firebase.initializeApp(options: options);
  try {
    HttpOverrides.global = MyHttpOverrides();
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  } on Exception catch (e) {
    log(e.toString());
  }
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
