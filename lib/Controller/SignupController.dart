import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var fullname = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  final formKey = GlobalKey<FormState>();

  void signup() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (password.value != confirmPassword.value) {
        Get.snackbar('Error', 'Passwords do not match',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('Success', 'Account Created Successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    }
  }
}