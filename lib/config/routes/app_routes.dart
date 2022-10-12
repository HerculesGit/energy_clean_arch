import 'package:flutter/material.dart';

import '../../presentation/views/battery_charging_view.dart';
import 'routes_constants.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case kBatteryChargingView:
        return _materialRoute(const BatteryChargingView());
      default:
        return _materialRoute(Scaffold(
          body: Column(
            children: const [Text('Route not found')],
          ),
        ));
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
