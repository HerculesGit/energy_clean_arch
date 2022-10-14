import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/models/particle.dart';

class ParticleAnimationController extends ChangeNotifier {
  late Timer timer;
  final speed = 0.09;
  final padding = 16.0;
  bool animationIsProgressing = false;

  bool down = true;

  // double value = 0.0;
  double maxDx = 0.0;
  double maxDy = 0.0;

  double j = 0.0;
  double k = 0.0;

  bool initialized = false;

  List<Particle> particles = [];

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  init() {
    if (initialized) return;
    _generateParticles();
    setInitialValue();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => startPlatformAnimation());
    initialized = true;
  }

  startPlatformAnimation() async {
    animationIsProgressing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      if (k >= maxDy) {
        down = false;
      }

      if (j <= 0.0) {
        down = true; // upToDown
      }

      if (down) {
        j += speed;
        k += speed;
        upToDownAnimation();
      } else {
        j -= speed;
        k -= speed;
        downToUpAnimation();
      }

      // print('j =>$j');
      // print('maxDy$maxDy');
      // print('k =>$k');
    });
    notifyListeners();
  }

  double get opacity => animationIsProgressing ? 1.0 : 0.0;

  double _random(double min, double max) {
    return min + Random().nextInt(max.toInt() - min.toInt());
  }

  _generateParticles() {
    particles = List.generate(
      5,
      (index) {
        final dx = _random(padding, maxDx - padding);
        final dy = _random(padding, maxDy - padding);
        print('dx $dx');
        print('dx $dy');
        return Particle(color: color, radius: radius)
          ..position = Offset(dx, dy);
      },
    );
  }

  final List<Color> _rangeColors = [
    const Color(0xFF69FFC4),
    const Color(0xFF4CCBA9),
    const Color(0xFF259D5B),
    const Color(0xFF182B27),
  ];

  final List<double> _rangeRadius = [
    1.0,
    2.0,
    4.0,
    4.0,
  ];

  Color get color {
    final position = Random.secure().nextInt(_rangeColors.length);
    return _rangeColors[position];
  }

  double get radius {
    final position = Random.secure().nextInt(_rangeRadius.length);
    return _rangeRadius[position];
  }

  void downToUpAnimation() {
    for (var p in particles) {
      p.position = Offset(p.position.dx, p.position.dy - speed);
    }
    notifyListeners();
  }

  void upToDownAnimation() {
    for (var p in particles) {
      p.position = Offset(p.position.dx, p.position.dy + speed);
    }
    notifyListeners();
  }

  setInitialValue() {
    final List<double> v = [];
    for (var p in particles) {
      v.add(p.position.dy);
    }

    j = v.reduce(min);
    k = v.reduce(max);
  }
}
