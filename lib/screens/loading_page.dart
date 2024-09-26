import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:say_anything/services/Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:say_anything/function/SocketServices.dart';
// ignore: implementation_imports
import 'package:socket_io_client/src/socket.dart';
import 'package:say_anything/controllers/LoadingController.dart';

class UserIdService {
  static Future<String> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId') ?? 'default_value';
    return userId;
  }
}

class LoadingPage extends StatefulWidget {
  final SocketService socketService;
  final User user;

  const LoadingPage(
      {super.key,
      required this.socketService,
      required this.user,
      required Socket socket});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late LoadingController controller;

  @override
  void initState() {
    super.initState();
    controller = LoadingController(
      socketService: widget.socketService,
      user: widget.user,
      context: context,
    );
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ModalBarrier(color: Colors.black.withOpacity(0.5)),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: const Color(0xFF7EC4CF),
                    size: 50,
                  ),
                  const SizedBox(height: 20),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Pairing...',
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 3,
            left: 0,
            right: 0,
            child: SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: () {
                  controller.cancelMatch();
                },
                backgroundColor: const Color(0xFF7EC4CF),
                child: const Icon(Icons.cancel, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
