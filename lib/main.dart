import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/View/HomeScreen.dart';
import 'package:mygram/View/LoginScreen.dart';
import 'package:mygram/View/Signup.dart';
import 'package:mygram/View/splash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: HomeScreen(),
    );
  }
}
