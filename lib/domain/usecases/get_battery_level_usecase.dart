import 'package:energy_clean_arch/domain/usecases/future_usecase.dart';

import '../../data/datasources/local/battery_client.dart';

class GetBatteryLevelUseCase extends FutureUseCase<void, double> {
  final BatteryClient _batteryClient;

  GetBatteryLevelUseCase(this._batteryClient);

  @override
  Future<double?>? call({required void params}) async {
    return await _batteryClient.getBatteryLevel();
  }
}
