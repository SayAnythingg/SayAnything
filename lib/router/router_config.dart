import 'package:SayAnything/router/router.dart';
import 'package:SayAnything/screens/SayAnything.dart';
import 'package:SayAnything/screens/forget_password.dart';
import 'package:SayAnything/screens/login_page.dart';
import 'package:SayAnything/screens/new_password.dart';
import 'package:SayAnything/screens/otp_verification.dart';
import 'package:SayAnything/screens/password_changed.dart';
import 'package:SayAnything/screens/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: Routers.authenticationpage.path,
    name: Routers.authenticationpage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: Sayanything());
    },
  ),
  GoRoute(
    path: Routers.loginpage.path,
    name: Routers.loginpage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: LoginPage());
    },
  ),
  GoRoute(
    path: Routers.signuppage.path,
    name: Routers.signuppage.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: SignupPage());
    },
  ),
  GoRoute(
    path: Routers.forgetpassword.path,
    name: Routers.forgetpassword.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: ForgetPasswordPage());
    },
  ),
  GoRoute(
    path: Routers.newpassword.path,
    name: Routers.newpassword.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: NewPasswordPage());
    },
  ),
  GoRoute(
    path: Routers.otpverification.path,
    name: Routers.otpverification.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: OtpVerificationPage());
    },
  ),
  GoRoute(
    path: Routers.passwordchanges.path,
    name: Routers.passwordchanges.name,
    pageBuilder: (context, state) {
      return const CupertinoPage(child: PasswordChangesPage());
    },
  ),
   
]);
