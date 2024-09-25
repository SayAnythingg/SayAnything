import 'package:rive/rive.dart' as rive;

class AnimationService {
  late rive.RiveAnimationController _riveController;

  AnimationService() {
    _riveController = rive.SimpleAnimation('idle');
  }

  rive.RiveAnimationController get controller => _riveController;

  void playAnimation() {
    _riveController.isActive = true;
  }
}
