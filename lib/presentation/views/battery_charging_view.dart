import 'package:energy_clean_arch/config/themes.dart';
import 'package:energy_clean_arch/presentation/controllers/energy_battery_state.dart';
import 'package:energy_clean_arch/presentation/widgets/particle_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/battery_mold.dart';
import '../widgets/title_legend_widget.dart';

class BatteryChargingView extends StatefulWidget {
  const BatteryChargingView({Key? key}) : super(key: key);

  @override
  State<BatteryChargingView> createState() => _BatteryChargingViewState();
}

class _BatteryChargingViewState extends State<BatteryChargingView> {
  final double height = 200;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Provider.of<EnergyBatteryState>(context, listen: false)
        .getBatteryLevel(height);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'w=${MediaQuery.of(context).size.width} h=${MediaQuery.of(context).size.height}');
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          _buildBatteryIcon(context),
          Padding(
            padding: const EdgeInsets.only(top: 32.0 * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildTimeToFullCharge(), _buildChargingRange()],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.asset(
                'assets/images/electric_car.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatteryIcon(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;

    final Size iconSize = Size(width, height);
    final double batteryRegion = MediaQuery.of(context).size.height * 0.5;

    return Consumer<EnergyBatteryState>(
      builder: (context, batteryStateModel, child) {
        if (batteryStateModel.isLoading) {
          /// the blank space
          return SizedBox(height: batteryRegion);
        }

        final maxWidthSpaceToParticles =
            (MediaQuery.of(context).size.width * 0.5) - iconSize.width / 2;

        final maxHeightSpaceToParticles =
            (MediaQuery.of(context).size.height * 0.4) * 0.8;

        return SizedBox(
          // color: Colors.red,
          height: batteryRegion,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -iconSize.height * 0.2,
                    // top: -100,
                    child: SizedBox.fromSize(
                      size: Size(
                        iconSize.width,
                        iconSize.height * batteryStateModel.batteryLevel,
                      ),
                      child: _buildLightLayer(),
                    ),
                  ),
                ],
              ),

              /// build background layer
              SizedBox.fromSize(size: iconSize, child: _buildBackgroundLayer()),

              /// build charging effect layer
              _buildChargingDegradeLayer(
                size: Size(
                  iconSize.width,
                  iconSize.height * batteryStateModel.batteryLevel,
                ),
              ),

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
                  color: Colors.red.withOpacity(0),
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
                  color: Colors.green.withOpacity(0),
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

  Widget _buildChargingDegradeLayer({required Size size}) => AnimatedContainer(
        width: size.width,
        height: size.height,
        curve: Curves.easeOutCubic,
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.src,
          gradient: AppTheme.chargingEffect,
        ),
      );

  Widget _buildLightLayer() => Container(decoration: AppTheme.lightEffect);

  /// fake
  Widget _buildTimeToFullCharge() =>
      const TitleLegend(title: '0h 23 min', legend: 'Time to full charge');

  /// fake
  Widget _buildChargingRange() => const TitleLegend(
      title: '134 km', titleColor: Color(0xFF259D5B), legend: 'Charging range');
}
