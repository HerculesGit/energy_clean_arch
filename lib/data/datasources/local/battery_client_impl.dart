import 'package:battery_plus/battery_plus.dart';

import 'battery_client.dart';

class BatteryClientImpl implements BatteryClient {
  @override
  Future<int>? getBatteryLevel() async {
    var battery = Battery();
    final level = await battery.batteryLevel;

    return level;
  }
}
