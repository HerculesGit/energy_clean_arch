import 'package:flutter/material.dart';

const kDisplayResultTextStyle = TextStyle();

const kDefaultMargin = 16.0;

class AppTheme {
  static Color get backgroundColor => const Color(0xFF030309);

  static Color get batteryBackgroundColor => const Color(0xFF1B2432);

  static Gradient get chargingEffect => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4CCBA9),
          Color(0xFF69FFC4),
          Color(0xFF259D5B),
        ],
      );

  static Decoration get lightEffect => const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x734CCBA9),
            blurRadius: 100,
            offset: Offset(0, 4),
          ),
        ],
      );
}
