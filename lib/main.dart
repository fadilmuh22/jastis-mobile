import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jastis/components/components.dart';
import 'package:jastis/controllers/controllers.dart';

import 'package:jastis/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  Get.put<AuthController>(AuthController());
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
