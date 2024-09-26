import 'package:flutter/material.dart';
import 'package:say_anything/services/API_services.dart';

class NewPasswordController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordResetService = PasswordResetApiService();

  Future<int> resetPassword(BuildContext context) async {
    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return -1;
    }

    final response = await passwordResetService.resetPassword(newPasswordController.text);
    if (response == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to reset password')),
      );
    }
    return response;
  }

  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}