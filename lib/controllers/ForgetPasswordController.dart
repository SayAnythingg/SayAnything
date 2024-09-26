import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/router/router.dart';

class ForgetPasswordController {
  final emailController = TextEditingController();
  final forgetPasswordApiService = ForgetPasswordApiService();

  Future<void> resetPassword(BuildContext context) async {
    try {
      await forgetPasswordApiService.resetPassword(emailController.text);
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pushNamed(Routers.otpverification.name);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void dispose() {
    emailController.dispose();
  }
}
