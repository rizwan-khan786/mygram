import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/Controller/splashcontroller.dart';

// SplashScreen Widget
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
 Get.put(Splashcontroller());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/01.png', // Add your splash image path here
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
