import 'package:flutter/material.dart';
import 'dart:math' as math;

class MultiRingLoader extends StatefulWidget {
  final double size;
  final List<Color> colors; // Colors for each ring
  final int ringCount;

  const MultiRingLoader({
    super.key,
    this.size = 120.0,
    this.ringCount = 4,
    this.colors = const [Colors.red, Colors.green, Colors.blue, Colors.orange],
  });

  @override
  State<MultiRingLoader> createState() => _MultiRingLoaderState();
}

class _MultiRingLoaderState extends State<MultiRingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(widget.ringCount, (index) {
              final progress = _controller.value;
              final sizeFactor = (index + 1) / widget.ringCount;
              final angle = (index.isEven ? progress : -progress) * 2 * math.pi;

              return Transform.rotate(
                angle: angle,
                child: CustomPaint(
                  painter: _RingPainter(
                    color: widget.colors[index % widget.colors.length],
                    strokeWidth: 5.0,
                  ),
                  size: Size(widget.size * sizeFactor, widget.size * sizeFactor),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _RingPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2 - strokeWidth / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final startAngle = 0.0;
    final sweepAngle = math.pi * 1.6; // partial ring for effect

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
