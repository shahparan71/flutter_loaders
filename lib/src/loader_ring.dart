import 'package:flutter/material.dart';

class LoaderRing extends StatefulWidget {
  final Color color;
  final double size;
  final double strokeWidth;
  final Duration duration;

  const LoaderRing({
    Key? key,
    this.color = Colors.blue,
    this.size = 50.0,
    this.strokeWidth = 4.0,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<LoaderRing> createState() => _LoaderRingState();
}

class _LoaderRingState extends State<LoaderRing> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Transform.rotate(
          angle: _controller.value * 2 * 3.1416,
          child: CustomPaint(
            painter: RingPainter(widget.color, widget.strokeWidth),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  RingPainter(this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    canvas.drawArc(rect, 0, 3.14 * 1.5, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
