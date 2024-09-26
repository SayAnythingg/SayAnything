import 'package:say_anything/common/common.dart';
import 'package:say_anything/screens/fade_animationtest.dart';
import 'package:say_anything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:say_anything/controllers/PasswordChangesPageController.dart';

class PasswordChangesPage extends StatefulWidget {
  const PasswordChangesPage({super.key});

  @override
  State<PasswordChangesPage> createState() => _PasswordChangesPageState();
}

class _PasswordChangesPageState extends State<PasswordChangesPage> {
  final PasswordChangesPageController _controller =
      PasswordChangesPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            LottieBuilder.asset("assets/images/ticker.json"),
            FadeInAnimation(
              delay: 1,
              child: Text(
                "Password Changed!",
                style: Common().titelTheme,
              ),
            ),
            FadeInAnimation(
              delay: 1.5,
              child: Text(
                "Your password has been changed successfully",
                style: Common().mediumThemeblack,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FadeInAnimation(
              delay: 2,
              child: CustomElevatedButton(
                message: "Back to Login",
                function: () {
                  _controller.navigateToLogin(context);
                },
                color: const Color(0xFF7EC4CF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
