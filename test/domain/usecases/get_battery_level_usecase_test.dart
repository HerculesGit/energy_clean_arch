import 'package:energy_clean_arch/data/datasources/local/battery_client.dart';
import 'package:energy_clean_arch/domain/usecases/get_battery_level_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class BatteryClientSpy extends Mock implements BatteryClient {}

void main() {
  group('Get Battery Level UseCase', () {
    test(
        'should be call the getBatteryLevel when GetBatteryLevelUseCase is called',
        () async {
      final batteryClient = BatteryClientSpy();
      final sut = GetBatteryLevelUseCase(batteryClient);
      await sut(params: null);

      verify(batteryClient.getBatteryLevel()).called(1);
      verifyNoMoreInteractions(batteryClient);
    });
  });
}
