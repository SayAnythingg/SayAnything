import 'package:say_anything/common/common.dart';
import 'package:say_anything/router/router.dart';
import 'package:say_anything/screens/fade_animationtest.dart';
import 'package:say_anything/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:say_anything/controllers/NewPasswordController.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final controller = NewPasswordController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Create new password",
                        style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Your new password must be unique from those previously used.",
                        style: Common().mediumThemeblack,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.9,
                        child: CustomTextFormField(
                          hinttext: 'New password',
                          obsecuretext: false,
                          controller: controller.newPasswordController,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: CustomTextFormField(
                          hinttext: 'Confirm password',
                          obsecuretext: false,
                          controller: controller.confirmPasswordController,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.4,
                        child: CustomElevatedButton(
                          message: "Reset Password ",
                          function: () async {
                            final response = await controller.resetPassword(context);
                            if (response == 200) {
                              GoRouter.of(context).pushNamed(Routers.passwordchanges.name);
                            }
                          },
                          color: const Color(0xFF7EC4CF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              FadeInAnimation(
                delay: 2.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: Common().hinttext,
                      ),
                      TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(Routers.signuppage.name);
                          },
                          child: Text(
                            "Register Now",
                            style: Common().mediumTheme,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}