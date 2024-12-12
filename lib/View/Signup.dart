import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/View/LoginScreen.dart';
import '../Controller/SignupController.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final SignupController controller = Get.put(SignupController());

  // Password visibility controllers
  final RxBool _passwordVisible = false.obs;
  final RxBool _confirmPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 246, 243, 250), // Light Violet Color
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8A2BE2), // Violet color
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildTextField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    onSave: (value) => controller.fullname.value = value!,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Full name is required' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    onSave: (value) => controller.email.value = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email is required';
                      if (!GetUtils.isEmail(value)) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      obscureText: !_passwordVisible.value,
                      onSave: (value) => controller.password.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Password is required';
                        if (value.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF8A2BE2), // Violet color
                        ),
                        onPressed: () => _passwordVisible.value = !_passwordVisible.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildTextField(
                      label: 'Confirm Password',
                      hint: 'Re-enter your password',
                      obscureText: !_confirmPasswordVisible.value,
                      onSave: (value) => controller.confirmPassword.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please confirm password';
                        if (value != controller.password.value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFF8A2BE2), // Violet color
                        ),
                        onPressed: () =>
                            _confirmPasswordVisible.value = !_confirmPasswordVisible.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8A2BE2), // Violet color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.signup,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Already have an account? Log in
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.offAll(LoginScreen()),
                      child: RichText(
                        text: const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: TextStyle(
                                color: Color(0xFF8A2BE2), // Violet color
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom TextField Widget
  Widget _buildTextField({
    required String label,
    required String hint,
    required String? Function(String?) validator,
    required void Function(String?) onSave,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8A2BE2), // Violet color
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF8A2BE2)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onSaved: onSave,
        ),
      ],
    );
  }
}
