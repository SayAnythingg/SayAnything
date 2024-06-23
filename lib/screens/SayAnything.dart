import 'package:SayAnything/router/router.dart';
import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as rive;

class Sayanything extends StatefulWidget {
  const Sayanything({super.key});

  @override
  State<Sayanything> createState() => _AuthenticationUIState();
}

class _AuthenticationUIState extends State<Sayanything> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                    const FadeInAnimation(
                      delay: 1,
                      child: SizedBox(
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
                      child: Image.asset('assets/images/title_logo_logo.png',
                          width: 250),
                    ),
                    FadeInAnimation(
                      delay: 1.5,
                      child:
                          Image.asset('assets/images/slogan.png', width: 200),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    FadeInAnimation(
                      delay: 2,
                      child: CustomElevatedButton(
                        message: "Login",
                        function: () {
                          GoRouter.of(context)
                              .pushNamed(Routers.loginpage.name);
                        },
                        color: const Color(0xFF7EC4CF),
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
                              side: const WidgetStatePropertyAll(
                                  BorderSide(color: Colors.black)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: const WidgetStatePropertyAll(
                                  Size.fromWidth(370)),
                              padding: const WidgetStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20),
                              ),
                              backgroundColor:
                                  const WidgetStatePropertyAll(Colors.white)),
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
