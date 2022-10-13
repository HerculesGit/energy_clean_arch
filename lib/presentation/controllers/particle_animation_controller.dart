import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/models/particle.dart';

class ParticleAnimationController extends ChangeNotifier {
  late Timer timer;
  final speed = 2;
  final padding = 16.0;

  bool downToUp = true;

  // double value = 0.0;
  double maxDx = 0.0;
  double maxDy = 0.0;

  double minDyParticlePosition = 0.0;
  double maxDyParticlePosition = 0.0;

  bool initialized = false;

  List<Particle> particles = [];

  init() {
    if (initialized) return;

    _generateParticles();
    setInitialValue();
    // timer = Timer.periodic(const Duration(milliseconds: 1000 ~/60), (timer) {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      /// tocou baixo
      if (minDyParticlePosition >= maxDy) {
        downToUp = false; // upToDown
      } else if (minDyParticlePosition <= 0) {
        /// tocou em cima
        downToUp = true;
      }

      if (downToUp) {
        minDyParticlePosition += speed;
        downToUpAnimation();
      } else {
        minDyParticlePosition -= speed;
        upToDownAnimation();
      }

      print('minDyParticlePosition=>$minDyParticlePosition');
      print('maxDy$maxDy');
    });

    initialized = true;
  }

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

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  void downToUpAnimation() {
    for (var p in particles) {
      p.position = Offset(p.position.dx, p.position.dy + speed);
    }
    notifyListeners();
  }

  void upToDownAnimation() {
    for (var p in particles) {
      p.position = Offset(p.position.dx, p.position.dy - speed);
    }
    notifyListeners();
  }

  setInitialValue() {
    final List<double> v = [];
    for (var p in particles) {
      v.add(p.position.dy);
    }

    minDyParticlePosition = v.reduce(min);
  }
}
