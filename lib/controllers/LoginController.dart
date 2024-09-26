import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:say_anything/screens/PrivacyPolicy_Page.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/services/Model.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final apiService = LoginApiService();

  bool isPasswordHidden = true;

  Future<void> login(BuildContext context) async {
    try {
      User user =
          await apiService.login(emailController.text, passwordController.text);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => PrivacyPolicyPage(user: user),
        ),
      );
    } catch (e) {
      String errorMessage;
      QuickAlertType alertType;
      if (e is LoginException) {
        switch (e.message) {
          case 'Login Failed, Please Check.':
            errorMessage = 'Incorrect password entered';
            alertType = QuickAlertType.error;
            break;
          case 'Account not confirmed. Please check your email.':
            errorMessage = 'Email not confirmed';
            alertType = QuickAlertType.warning;
            break;
          case 'User not exists. Please sign up first.':
            errorMessage = 'This user does not exist';
            alertType = QuickAlertType.warning;
            break;
          default:
            errorMessage = 'Failed';
            alertType = QuickAlertType.error;
            break;
        }
      } else {
        errorMessage =
            'The server is under maintenance, engineers are working hard to improve user quality';
        alertType = QuickAlertType.info;
      }
      QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: alertType,
        title: 'Oops...',
        text: errorMessage,
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
