import 'package:SayAnything/common/common.dart';
import 'package:SayAnything/screens/fade_animationtest.dart';
import 'package:SayAnything/screens/loading_page.dart';
import 'package:SayAnything/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:SayAnything/services/API_services.dart';

final apiService = SignupApiService();

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> performWithLoading(
      Future<void> Function() asyncOperation) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingPage(),
    );

    await asyncOperation();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInAnimation(
                  delay: 0.6,
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
                        delay: 0.9,
                        child: Text(
                          "Hello! Register to get  ",
                          style: Common().titelTheme,
                        ),
                      ),
                      FadeInAnimation(
                        delay: 1.2,
                        child: Text(
                          "started",
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
                          delay: 1.5,
                          child: CustomTextFormField(
                            hinttext: 'Username',
                            obsecuretext: false,
                            controller: usernameController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Gender',
                            ),
                            items:
                                <String>['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              genderController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hinttext: 'Email',
                          obsecuretext: false,
                          controller: emailController,
                          addSuffix: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.1,
                          child: CustomTextFormField(
                            hinttext: 'Password',
                            obsecuretext: true,
                            controller: passwordController,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.4,
                          child: CustomTextFormField(
                            hinttext: 'Confirm password',
                            obsecuretext: true,
                            controller: confirmPasswordController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 2.7,
                          child: CustomElevatedButton(
                            message: "Register",
                            function: () async {
                              if (usernameController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  genderController.text.isEmpty ||
                                  confirmPasswordController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF7EC4CF),
                                      title: Text('Error'),
                                      content: Text(
                                          'Please make sure all fields are entered.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Confirm'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF7EC4CF),
                                      title: Text('Error'),
                                      content: Text(
                                          'Please make sure the password and confirm password are the same.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Confirm'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF7EC4CF),
                                      title: Text('Verification code sent'),
                                      content: Text(
                                          'Please check your email for a verification code and to confirm your account.'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Confirm'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                await apiService.registerUser(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  genderController.text,
                                );
                              }
                            },
                            color: Color(0xFF7EC4CF),
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
                    height: 160,
                    width: double.infinity,
                    child: Column(
                      children: [
                        FadeInAnimation(
                          delay: 2.9,
                          child: Text(
                            "Or Register with",
                            style: Common().semiboldblack,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInAnimation(
                          delay: 3.2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 30, left: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "assets/images/google_ic-1.svg"),
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
