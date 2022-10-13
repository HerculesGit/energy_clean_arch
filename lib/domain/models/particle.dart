import 'package:flutter/material.dart';

class Particle {
  late Offset position;
  late Offset original;

  final Color color;
  final double radius;

  Particle({required this.color, required this.radius});
}
