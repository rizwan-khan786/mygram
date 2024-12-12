import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/View/Signup.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Success', 'Logged in successfully',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register() {
    // Navigate to the register page
    Get.offAll(SignupPage());
  }
}