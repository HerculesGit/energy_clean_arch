import 'package:energy_clean_arch/domain/usecases/get_battery_level_usecase.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/local/battery_client.dart';
import 'data/datasources/local/battery_client_impl.dart';

GetIt injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<BatteryClient>(BatteryClientImpl());

  /// usecases
  injector.registerSingleton<GetBatteryLevelUseCase>(
      GetBatteryLevelUseCase(injector()));
}
