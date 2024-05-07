import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mudara_steel_app/common/constant.dart';
import 'package:mudara_steel_app/routes/app_routes.dart';

class AppNotification{


  notificationListener()async{
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'mudra', // id
      'mudra', // title
      // 'This channel is used for important notifications.', // description
      importance: Importance.max,
      showBadge: true,
    );

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon',);
     DarwinInitializationSettings darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {}
    );
    var initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS:darwinInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);



    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      log(message.notification!.title.toString());
      // AndroidNotification android = message.notification?.android;
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null ) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    // channel.description,
                    icon: 'app_icon',
                    // color: ThemeService.primaryColor,
                    importance: Importance.max,

                  // other properties...
                ),
                iOS: const DarwinNotificationDetails(
                  threadIdentifier: Constants.appName
                )
            ),
        );
        flutterLocalNotificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (plyLoad){
          log(message.data['screen']);
          if (message.data['screen'] == 'bidList') {
            Get.toNamed(Routes.applyJob,arguments: message.data['jobId']);
            // navigatorKey.currentState!.pushNamed(Routes.notification);
          }
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(message.data['screen']);
      if (message.data['screen'] == 'bidList') {
        Get.toNamed(Routes.applyJob,arguments: message.data['jobId']);
      }
    });

  }

  initiosPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
    String? token = await messaging.getToken();
    log("token=${token!}");
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

   // badger() async{
   //   FirebaseMessaging.onBackgroundMessage((message) {
   //     FlutterAppBadger.isAppBadgeSupported();
   //     if(message.notification != null){
   //       return FlutterAppBadger.updateBadgeCount(1);
   //     }else{
   //       return FlutterAppBadger.removeBadge();
   //     }
   //   });
   // }


  // backgroundSetting()async{
  //   //GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  //   RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  //   if(message != null){
  //     if (message.data['screen'] == 'notification') {
  //       Get.toNamed(Routes.notification);
  //       //navigatorKey.currentState!.pushNamed(Routes.notification);
  //     }
  //   }else{
  //     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       log(message.data['screen']);
  //       if (message.data['screen'] == 'notification') {
  //         Get.toNamed(Routes.notification);
  //         // navigatorKey.currentState!.pushNamed(Routes.notification);
  //       }
  //     });
  //   }
  // }

  // static Future showNotification(RemoteMessage message) async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'sakhiya', // id
  //     'sakhiya', // title
  //     // 'This channel is used for important notifications.', // description
  //     importance: Importance.max,
  //     showBadge: true,
  //   );
  //
  //   await flutterLocalNotificationsPlugin.show(
  //       message.notification.hashCode,
  //       message.notification!.title,
  //       message.notification!.body,
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             // channel.description,
  //             //color: ThemeService.primaryColor,
  //             enableLights: true,
  //             enableVibration: true,
  //             priority: Priority.high,
  //             importance: Importance.max,
  //             icon:"app_icon",
  //             styleInformation: const MediaStyleInformation(
  //               htmlFormatContent: true,
  //               htmlFormatTitle: true,
  //             ),
  //             playSound: true,
  //             // other properties...
  //           ),
  //           iOS: const DarwinNotificationDetails(
  //               threadIdentifier: AppConstants.AppName
  //           )
  //       ));
  // }

  // static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin)async{
  //
  //   var androidinitialize = const AndroidInitializationSettings('app_icon');
  //   var iosinitialize = const DarwinInitializationSettings();
  //   var initializationSettings = InitializationSettings(android: androidinitialize,iOS: iosinitialize);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //       onSelectNotification: (String payload) async {
  //     if (payload != null) {
  //       debugPrint('notification payload: ' + payload);
  //     }
  //   });
  // }

}