import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/models/particle.dart';

class ParticleAnimationController extends ChangeNotifier {
  late Timer timer;
  final speed = 0.5;
  double value = 0.0;
  double maxDx = 0.0;
  double maxDy = 0.0;

  bool initialized = false;

  List<Particle> particles = [];

  init() {
    _generateParticles();  if (initialized) return;
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      if (value <= 10) {
        value += speed;

        // updateParticlePosition();
      }
    });

    initialized = true;
    // _generateParticles();
  }

  double _random(double min, double max) {
    return min + Random().nextInt(max.toInt() - min.toInt());
  }

  _generateParticles() {
    particles = List.generate(
      5,
      (index) {
        const padding = 16.0;

        final dx = _random(padding, maxDx - padding);
        //= Random().nextInt((maxDx * 1.8).toInt()).toDouble();
        final dy = _random(200, maxDy - padding);
        //= Random().nextInt((maxDy * 2).toInt()).toDouble();
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

  updateParticlePosition() {
    for (var p in particles) {
      p.position = Offset(p.position.dx, p.position.dy - value);
    }
    notifyListeners();
  }
}
