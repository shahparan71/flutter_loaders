import 'dart:math' as math;
import 'package:flutter/material.dart';

class AtomicParticlesLoader extends StatefulWidget {
  final double size;
  final Duration duration;

  const AtomicParticlesLoader({
    super.key,
    this.size = 150,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AtomicParticlesLoader> createState() => _AtomicParticlesLoaderState();
}

class _AtomicParticlesLoaderState extends State<AtomicParticlesLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final int protonCount = 3;
  final int neutronCount = 3;
  final int electronCount = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset orbitPosition(double angle, double radius) {
    return Offset(
      radius * math.cos(angle),
      radius * math.sin(angle),
    );
  }

  Widget _buildNucleusParticle(Color color, double dx, double dy) {
    return Positioned(
      left: widget.size / 2 + dx - 6,
      top: widget.size / 2 + dy - 6,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildElectron(double radius, double angleOffset, Color color, double scale) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final angle = (_controller.value * 2 * math.pi) + angleOffset;
        final offset = orbitPosition(angle, radius);

        return Positioned(
          left: widget.size / 2 + offset.dx - 5,
          top: widget.size / 2 + offset.dy - 5,
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final nucleusRadius = 15.0;
    final electronColors = [Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent];

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Nucleus (protons and neutrons)
          ...List.generate(protonCount, (i) {
            final angle = i * 2 * math.pi / protonCount;
            final dx = nucleusRadius * math.cos(angle);
            final dy = nucleusRadius * math.sin(angle);
            return _buildNucleusParticle(Colors.red, dx, dy);
          }),
          ...List.generate(neutronCount, (i) {
            final angle = i * 2 * math.pi / neutronCount + math.pi / neutronCount;
            final dx = (nucleusRadius - 5) * math.cos(angle);
            final dy = (nucleusRadius - 5) * math.sin(angle);
            return _buildNucleusParticle(Colors.grey.shade700, dx, dy);
          }),

          // Orbiting electrons
          ...List.generate(electronCount, (i) {
            final radius = widget.size * 0.35 + (i * 10);
            final angleOffset = i * math.pi / 1.5;
            return _buildElectron(radius, angleOffset, electronColors[i % electronColors.length], 1.0);
          }),
        ],
      ),
    );
  }
}
