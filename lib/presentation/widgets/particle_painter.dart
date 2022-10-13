import 'package:energy_clean_arch/presentation/controllers/particle_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/particle.dart';

class ParticlesWidget extends StatelessWidget {
  final double height;
  final double width;

  const ParticlesWidget({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticleAnimationController>(
      builder: (context, particleController, child) {
        particleController.maxDx = width;
        particleController.maxDy = height;
        particleController.init();

        print('size --> ${width} ${height}');
        print('maxDx --> ${particleController.maxDx } ${height}');
        print('maxDy --> ${particleController.maxDy } ${height}');

        return Container(
          width: width,
          // color: Colors.red,
          child: CustomPaint(
            painter: ParticlePainter(particles: particleController.particles),
          ),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    // draw particles
    for (var particle in particles) {
      var paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
