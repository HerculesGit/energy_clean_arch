import 'package:energy_clean_arch/domain/usecases/get_battery_level_usecase.dart';
import 'package:flutter/material.dart';

class EnergyBatteryState extends ChangeNotifier {
  final GetBatteryLevelUseCase _getBatteryLevelUseCase;

  EnergyBatteryState(this._getBatteryLevelUseCase);

  bool isLoading = true;
  int level = 0;
  double capacity = 100.0;
  double zero = 0.0;
  bool isAnimationCharging = false;

  /// 0%=empty; 100%=full
  double get batteryLevel {
    if (!isAnimationCharging) return 0.0;
    return ((level * 100) / capacity) / 100;
  }

  Future<void> getBatteryLevel(double capacity) async {
    isLoading = true;
    final batteryLevel = await _getBatteryLevelUseCase.call(params: null);
    level = batteryLevel ?? 0;
    isLoading = false;

    await Future.delayed(Duration(seconds: 1));
    startEnergyChargingAnimation();
  }

  void startEnergyChargingAnimation() {
    isAnimationCharging = true;
    notifyListeners();
  }
}
