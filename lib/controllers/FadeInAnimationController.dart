import 'package:flutter/material.dart';

class FadeInAnimationController {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> animation2;

  FadeInAnimationController(TickerProvider vsync, double delay) {
    controller = AnimationController(
      duration: Duration(milliseconds: (500 * delay).round()),
      vsync: vsync,
    );
    animation2 = Tween<double>(begin: -40, end: 0).animate(controller);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  void forward() {
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}