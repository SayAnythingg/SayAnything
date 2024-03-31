import 'dart:ui';

import 'package:SayAnything/common/common.dart';
import 'package:SayAnything/router/router.dart';
import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as rive;

class AuthenticationUI extends StatefulWidget {
  const AuthenticationUI({super.key});

  @override
  State<AuthenticationUI> createState() => _AuthenticationUIState();
}

class _AuthenticationUIState extends State<AuthenticationUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SizedBox(
                child: Column(
                  children: [
                    FadeInAnimation(
                      delay: 1,
                      child: Container(
                        height: 150,
                        width: 150,
                        child: rive.RiveAnimation.asset(
                          'assets/animation/cat.riv',
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.5,
                      child: Text(
                        "SayAnything",
                        style: Common().titelTheme.copyWith(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeInAnimation(
                      delay: 2,
                      child: CustomElevatedButton(
                        message: "Login",
                        function: () {
                          GoRouter.of(context).pushNamed(Routers.loginpage.name);
                        },
                        color: Color(0xFF7EC4CF),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInAnimation(
                      delay: 2.5,
                      child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(Routers.signuppage.name);
                          },
                          style: ButtonStyle(
                              side: const MaterialStatePropertyAll(
                                  BorderSide(color: Colors.black)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: const MaterialStatePropertyAll(
                                  Size.fromWidth(370)),
                              padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20),
                              ),
                              backgroundColor:
                                  const MaterialStatePropertyAll(Colors.white)),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Urbanist-SemiBold",
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7EC4CF)),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}