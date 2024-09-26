import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPageController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> saveInputData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('gender', genderController.text);
    await prefs.setString('confirmPassword', confirmPasswordController.text);
  }

  Future<void> loadInputData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usernameController.text = prefs.getString('username') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    genderController.text = prefs.getString('gender') ?? '';
    confirmPasswordController.text = prefs.getString('confirmPassword') ?? '';
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
    confirmPasswordController.dispose();
  }
}
