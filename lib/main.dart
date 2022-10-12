import 'package:energy_clean_arch/data/datasources/local/battery_client_impl.dart';
import 'package:energy_clean_arch/presentation/controllers/energy_battery_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';
import 'inject.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => EnergyBatteryState(injector()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calc',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
