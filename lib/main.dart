import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jastis/components/components.dart';
import 'package:jastis/controllers/controllers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:jastis/data/data.dart';

import 'package:jastis/pages/pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: android?.smallIcon,
            importance: Importance.max,
            priority: Priority.high,
          ),
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  await initNotifications(flutterLocalNotificationsPlugin);

  // await flutterLocalNotificationsPlugin.zonedSchedule(
  //   0,
  //   'scheduled title',
  //   'scheduled body',
  //   tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
  //   const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'your channel id',
  //       'your channel name',
  //       'your channel description',
  //     ),
  //   ),
  //   androidAllowWhileIdle: true,
  //   uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime,
  // );

  await Firebase.initializeApp();
  await PushNotificationsManager().init();
  FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);

  await GetStorage.init();

  Get.put<AuthController>(AuthController());
  Get.put<ScreenController>(ScreenController());
  Get.put<KelasController>(KelasController());
  Get.put<CreateController>(CreateController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initOverlays(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jastis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xFF5E5454),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          headline2: TextStyle(
            color: Color(0xFF5E5454),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          caption: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          subtitle1: TextStyle(
            color: Colors.black.withOpacity(.41),
            fontSize: 11,
          ),
          subtitle2: TextStyle(
            color: Colors.black.withOpacity(.41),
            fontSize: 8,
          ),
        ),
      ),
      home: SplashPage(),
    );
  }
}
