import 'package:flutter/material.dart';
import 'package:say_anything/controllers/FadeInAnimationController.dart';

class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation({super.key, required this.child, required this.delay});

  final Widget child;
  final double delay;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with TickerProviderStateMixin {
  late FadeInAnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = FadeInAnimationController(this, widget.delay);
    controller.animation.addListener(() {
      setState(() {});
    });
    controller.animation2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Transform.translate(
      offset: Offset(0, controller.animation2.value),
      child: Opacity(
        opacity: controller.animation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
