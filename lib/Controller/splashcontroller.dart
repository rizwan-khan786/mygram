

import 'package:get/get.dart';
import 'package:mygram/View/LoginScreen.dart';

class Splashcontroller extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

   Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(const Loginscreen()); 
    });
  }
}