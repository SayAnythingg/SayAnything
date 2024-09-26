import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:say_anything/router/router.dart';

class PasswordChangesPageController {
  void navigateToLogin(BuildContext context) {
    GoRouter.of(context).pushReplacement(Routers.loginpage.name);
  }
}