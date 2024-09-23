import 'dart:async';
import 'package:say_anything/common/common.dart';
import 'package:say_anything/screens/fade_animationtest.dart';
import 'package:say_anything/screens/loading_page.dart';
import 'package:say_anything/screens/login_page.dart';
import 'package:say_anything/widgets/custom_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';

final apiService = SignupApiService();
final resendMailService = ResendConfirmationMailService();
final userConfirmService = UserConfirmStatusService();

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
  bool _hasAttemptedRegister = false;
  Timer? _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel();
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
          _saveTimerState();
        });
      }
    });
  }

  Future<void> _saveTimerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('timer_start', _start);
    prefs.setInt('timer_last_update', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _loadTimerState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedStart = prefs.getInt('timer_start');
    int? lastUpdate = prefs.getInt('timer_last_update');

    if (savedStart != null && lastUpdate != null) {
      int elapsed =
          ((DateTime.now().millisecondsSinceEpoch - lastUpdate) / 1000).round();
      int newStart = savedStart - elapsed;
      if (newStart > 0) {
        setState(() {
          _start = newStart;
        });
      } else {
        setState(() {
          _start = 0;
        });
      }
    }
  }

  Future<void> _registerUser() async {
    if (userConfirmService.response.body == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  Future<void> _saveInputData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('gender', genderController.text);
    await prefs.setString('confirmPassword', confirmPasswordController.text);
  }

  Future<void> _loadInputData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usernameController.text = prefs.getString('username') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      genderController.text = prefs.getString('gender') ?? '';
      confirmPasswordController.text = prefs.getString('confirmPassword') ?? '';
    });
  }

  void _attemptRegister() {
    setState(() {
      _hasAttemptedRegister = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadInputData();
    _loadTimerState().then((_) => startTimer());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _saveInputData();
    super.dispose();
  }

  Future<void> performWithLoading(
      Future<void> Function() asyncOperation) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const LoadingPage(),
    );

    await asyncOperation();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
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
                            decoration: const InputDecoration(
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
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Error',
                                  text:
                                      'Please make sure all fields are entered.',
                                  confirmBtnText: 'Confirm',
                                  confirmBtnColor: const Color(0xFF7EC4CF),
                                  onConfirmBtnTap: () =>
                                      Navigator.of(context).pop(),
                                );
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'Error',
                                  text:
                                      'Please make sure the password and confirm password are the same.',
                                  confirmBtnText: 'Confirm',
                                  confirmBtnColor: const Color(0xFF7EC4CF),
                                  onConfirmBtnTap: () =>
                                      Navigator.of(context).pop(),
                                );
                              } else {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  title: 'Verification code sent',
                                  text:
                                      'Please check your email for a verification code and to confirm your account.',
                                  confirmBtnText: 'Confirm',
                                  confirmBtnColor: const Color(0xFF7EC4CF),
                                  onConfirmBtnTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _start = 120;
                                      startTimer();
                                      _attemptRegister();
                                    });
                                  },
                                );
                                await apiService.registerUser(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  genderController.text,
                                );
                                await _registerUser();
                              }
                            },
                            color: const Color(0xFF7EC4CF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_hasAttemptedRegister)
                  FadeInAnimation(
                    delay: 2.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't receive the email? "),
                        TextButton(
                          onPressed: _start > 0
                              ? null
                              : () async {
                                  startTimer();
                                  setState(() {
                                    _start = 120;
                                  });

                                  final result = await resendMailService
                                      .resendConfirmationMail(
                                          emailController.text);
                                  if (result['confirmStatus']) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Confirmation mail resent successfully.")));
                                  }
                                },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF7EC4CF),
                          ),
                          child: Text(_start > 0 ? '$_start s' : 'Resend'),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
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
