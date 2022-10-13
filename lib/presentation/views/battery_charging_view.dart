import 'package:energy_clean_arch/config/themes.dart';
import 'package:energy_clean_arch/presentation/controllers/energy_battery_state.dart';
import 'package:energy_clean_arch/presentation/widgets/particle_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/battery_mold.dart';

class BatteryChargingView extends StatefulWidget {
  const BatteryChargingView({Key? key}) : super(key: key);

  @override
  State<BatteryChargingView> createState() => _BatteryChargingViewState();
}

class _BatteryChargingViewState extends State<BatteryChargingView> {
  final double height = 200;

  @override
  void didChangeDependencies() {
    Provider.of<EnergyBatteryState>(context).getBatteryLevel(height);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'w=${MediaQuery.of(context).size.width} h=${MediaQuery.of(context).size.height}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildBatteryIcon(context);
  }

  Widget _buildBatteryIcon(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;

    final Size iconSize = Size(width, height);

    return Consumer<EnergyBatteryState>(
      builder: (context, batteryStateModel, child) {
        if (batteryStateModel.isLoading) {
          return const CircularProgressIndicator();
        }

        final maxWidthSpaceToParticles =
            (MediaQuery.of(context).size.width * 0.5) - iconSize.width / 2;

        final maxHeightSpaceToParticles =
            (MediaQuery.of(context).size.height * 0.5) * 0.8;

        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Stack(
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

              /// left
              Positioned(
                left: 0,
                child: Container(
                  width: (MediaQuery.of(context).size.width * 0.5) -
                      iconSize.width / 2,
                  height: maxHeightSpaceToParticles,
                  color: Colors.red.withOpacity(0.2),
                  child: ParticlesWidget(
                    width: maxWidthSpaceToParticles,
                    height: maxHeightSpaceToParticles,
                  ),
                ),
              ),

              /// right
              Positioned(
                // left: maxWidthOfTheRightParticles,
                right: 0,
                child: Container(
                  width: (MediaQuery.of(context).size.width * 0.5) -
                      iconSize.width / 2,
                  height: maxHeightSpaceToParticles,
                  color: Colors.green.withOpacity(.2),
                  child: ParticlesWidget(
                    width: maxWidthSpaceToParticles,
                    height: maxHeightSpaceToParticles,
                  ),
                ),
              ),
            ],
          ),
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
