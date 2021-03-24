import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jastis/pages/pages.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
