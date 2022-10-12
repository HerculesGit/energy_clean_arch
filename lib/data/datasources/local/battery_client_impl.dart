import 'package:battery_plus/battery_plus.dart';

import 'battery_client.dart';

class BatteryClientImpl implements BatteryClient {
  @override
  Future<double>? getBatteryLevel() async {
    var battery = Battery();
    final level = await battery.batteryLevel;

    return double.parse(level.toString());
  }
}
