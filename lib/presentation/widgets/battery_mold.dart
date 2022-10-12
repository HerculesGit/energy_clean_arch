import 'package:energy_clean_arch/config/themes.dart';
import 'package:flutter/material.dart';

class BatteryMold extends StatelessWidget {
  const BatteryMold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomPaint(painter: MyPainter());
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill
      ..color = AppTheme.backgroundColor;
    final center = size.center(Offset.zero);

    final Path path = Path();
    path.fillType = PathFillType.evenOdd;

    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        const Radius.circular(25)));

    path.addRect(Rect.fromCenter(
        center: center, width: size.width, height: size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
