import 'package:energy_clean_arch/config/themes.dart';
import 'package:energy_clean_arch/presentation/controllers/energy_battery_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/battery_mold.dart';

class BatteryChargingView extends StatelessWidget {
  const BatteryChargingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildBatteryIcon(context);
  }

  Widget _buildBatteryIcon(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;
    const double height = 200;

    final Size iconSize = Size(width, height);

    return Consumer<EnergyBatteryState>(
      builder: (context, batteryStateModel, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            /// build background layer
            SizedBox.fromSize(size: iconSize, child: _buildBackgroundLayer()),

            /// build charging effect layer
            SizedBox.fromSize(
                size: Size(
                  iconSize.width,
                  iconSize.height * batteryStateModel.batteryLevel,
                ),
                child: _buildChargingDegradeLayer()),

            /// build mold layer
            SizedBox(
              height: iconSize.height,
              width: iconSize.width,
              child: const BatteryMold(),
            ),

            /// build light layer
            SizedBox.fromSize(
              size: Size(
                iconSize.width,
                iconSize.height * batteryStateModel.batteryLevel,
              ),
              child: _buildLightLayer(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBackgroundLayer() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppTheme.batteryBackgroundColor,
        ),
      );

  Widget _buildChargingDegradeLayer() => Container(
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.src,
          gradient: AppTheme.chargingEffect,
        ),
      );

  Widget _buildLightLayer() => Container(decoration: AppTheme.lightEffect);
}
