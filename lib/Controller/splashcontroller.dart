

import 'package:get/get.dart';
import 'package:mygram/View/LoginScreen.dart';
import 'package:mygram/View/OnBoarding/Onboarding.dart';

class Splashcontroller extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

   Future.delayed(const Duration(seconds: 2), () {
      Get.offAll( OnBoardingScreen()); 
    });
  }
}