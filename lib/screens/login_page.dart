import 'package:SayAnything/common/common.dart';
import 'package:SayAnything/router/router.dart';
import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/screens/Main_page.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:SayAnything/services/API_services.dart';
import 'package:shared_preferences/shared_preferences.dart';


final apiService = LoginApiService();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool flag = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

    bool _isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

 Future<void> _login() async {
  try {
    String userId = (await apiService.login(emailController.text, passwordController.text)) as String;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    /*
    await prefs.setString('name', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);
    */
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(initialIndex: 1),
      ),
    );
  } catch (e) {
    print('Failed to log in');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to log in: $e'),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(Routers.authenticationpage.name);
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
                        "Welcome back! Glad ",
                        style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "to see you, Again!",
                        style: Common().titelTheme,
                      ),
                    ),
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
                          controller: emailController,
                          hinttext: 'Enter your email',
                          obsecuretext: false,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInAnimation(
                        delay: 2.2,
                        child: TextFormField(
                          controller: passwordController,
                          // Modify this line
                          obscureText: _isPasswordHidden,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18),
                            hintText: "Enter your password",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              // Modify this line
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),
                        ),
                      ),
                      FadeInAnimation(
                        delay: 2.5,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                GoRouter.of(context)
                                    .pushNamed(Routers.forgetpassword.name);
                              },
                              child: Text(
                                "Forget Password?",
                                style: Common().semiboldblack,
                              )),
                        ),
                      ),
                      FadeInAnimation(
                        delay: 2.8,
                        child: CustomElevatedButton(
                          message: "Login",
                          function: () {
                            _login();
                          },
                          color:  Color(0xFF7EC4CF), 
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 2.2,
                        child: Text(
                          "Or Log with",
                          style: Common().semiboldblack,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInAnimation(
                      delay: 2.4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 30, left: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,  
                          mainAxisAlignment: MainAxisAlignment.center,  
                          children: [
                            SvgPicture.asset("assets/images/google_ic-1.svg"),
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
