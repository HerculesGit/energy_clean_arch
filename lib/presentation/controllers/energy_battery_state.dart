import 'package:flutter/material.dart';

class EnergyBatteryState extends ChangeNotifier {
  // bool isCharging = false;
  // bool isFull = false;
  // bool isEmpty = false;

  // double percentagePoints = 0.0;

  double _level = 100;
  double _capacity = 200;

  /// 0%=empty; 100%=full
  double get batteryLevel {
    return ((_level * 100) / _capacity) / 100;
  }
}
