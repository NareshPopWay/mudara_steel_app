import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/demo_localization.dart';
import 'package:mudara_steel_app/common/MultiLanguage/localization/language_constant.dart';
import 'package:mudara_steel_app/common/MultiLanguage/phoenix.dart';
import 'package:mudara_steel_app/common/responsive_layout_builder.dart';
import 'package:mudara_steel_app/common/scale_factors.dart';
import 'package:mudara_steel_app/common/themeService.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';
import 'package:mudara_steel_app/routes/page_routes.dart';
import 'package:permission_handler/permission_handler.dart';

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

  if (Platform.isIOS) {
    await Permission.notification.isDenied.then(
          (bool value) {
        if (value) {
          Permission.notification.request();
        }
      },
    );
  }

  FirebaseOptions options;
  if (Platform.isAndroid) {
    options = const FirebaseOptions(
        apiKey: "AIzaSyCMPMhF9ZSKrHtGj9L79p5JyIzbdAe4Md8",
        appId: "1:600149927142:android:5d700a946b003171644727",
        messagingSenderId: "600149927142",
        projectId: "mudrasteel-711c1");
  } else {
    options = const FirebaseOptions(
        apiKey: "AIzaSyCqCY576bDq3h-ntKZYpQSsv5zm66iHpww",
        appId: "1:600149927142:ios:4b5dc96535b35675644727",
        messagingSenderId: "600149927142",
        projectId: "mudrasteel-711c1");
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
      small: (BuildContext context, Widget? child) => DemoGeofence(
        child: MyApp(
          lightTheme: Get.find<ThemeService>()
              .getLightTheme(scaleFactor: DeviceScaleFactors.smallScaleFactor),
          darkTheme: Get.find<ThemeService>()
              .getDarkTheme(scaleFactor: DeviceScaleFactors.smallScaleFactor),
        ),
      ),
      medium: (BuildContext context, Widget? child) => DemoGeofence(
        child: MyApp(
          lightTheme: Get.find<ThemeService>()
              .getLightTheme(scaleFactor: DeviceScaleFactors.mediumScaleFactor),
          darkTheme: Get.find<ThemeService>()
              .getDarkTheme(scaleFactor: DeviceScaleFactors.mediumScaleFactor),
        ),
      ),
      large: (BuildContext context, Widget? child) => DemoGeofence(
        child: MyApp(
          lightTheme: Get.find<ThemeService>()
              .getLightTheme(scaleFactor: DeviceScaleFactors.largeScaleFactor),
          darkTheme: Get.find<ThemeService>()
              .getDarkTheme(scaleFactor: DeviceScaleFactors.largeScaleFactor),
        ),
      ),
      xLarge: (BuildContext context, Widget? child) => DemoGeofence(
        child: MyApp(
          lightTheme: Get.find<ThemeService>()
              .getLightTheme(scaleFactor: DeviceScaleFactors.xLargeScaleFactor),
          darkTheme: Get.find<ThemeService>()
              .getDarkTheme(scaleFactor: DeviceScaleFactors.xLargeScaleFactor),
        ),
      ),
    ),
  );
  Get.lazyPut(() => ThemeService());
}

// class MyApp extends StatelessWidget {
//   final ThemeData lightTheme;
//   final ThemeData darkTheme;
//
//   const MyApp({Key? key, required this.lightTheme, required this.darkTheme})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//     return GetMaterialApp(
//       title: "Mudra Steel",
//       initialRoute: PageRoutes.initial,
//       getPages: PageRoutes.routes,
//       defaultTransition: Transition.cupertino,
//       themeMode: Get.find<ThemeService>().getThemeMode(),
//       theme: lightTheme,
//       darkTheme: darkTheme,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class MyApp extends StatefulWidget {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  const MyApp({Key? key, required this.lightTheme, required this.darkTheme})
      : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!)),
        ),
      );
    } else {
      return GetMaterialApp(
        title: "Mudra Steel",
        initialRoute: PageRoutes.initial,
        getPages: PageRoutes.routes,
        defaultTransition: Transition.cupertino,
        themeMode: Get.find<ThemeService>().getThemeMode(),
        theme: widget.lightTheme,
        darkTheme: widget.darkTheme,
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("hi", "IN"),
          Locale("en", "US"),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the current locale doesn't match with any of the
          // supportedLocales, use the first supportedLocale, i.e., English.
          return supportedLocales.first;
        },
      );
    }
  }
}

