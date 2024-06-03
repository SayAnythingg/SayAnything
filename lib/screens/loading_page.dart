import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:SayAnything/services/API_services.dart';
import 'package:SayAnything/screens/home.dart';

MatchApiService matchApiService = MatchApiService();

class LoadingPage extends StatelessWidget {
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
                    color: Color(0xFF7EC4CF),
                    size: 50,
                  ),
                  SizedBox(height: 20),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Pairing...',
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        speed: Duration(milliseconds: 200),
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
            child: Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: () async {
                  String userId = await UserIdService.getCurrentUserId();
                  Navigator.pop(context);
                  await matchApiService.cancelMatch(userId);
                },
                child: Icon(Icons.cancel, size: 20),
                backgroundColor: Color(0xFF7EC4CF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
