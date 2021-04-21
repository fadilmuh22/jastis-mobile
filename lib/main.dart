import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jastis/components/components.dart';
import 'package:jastis/controllers/controllers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:jastis/data/data.dart';

import 'package:jastis/pages/pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
