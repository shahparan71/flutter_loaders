import 'package:flutter/material.dart';
import 'dart:math';

class ECGAnimationWidget extends StatefulWidget {
  @override
  _ECGAnimationWidgetState createState() => _ECGAnimationWidgetState();
}

class _ECGAnimationWidgetState extends State<ECGAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Control animation speed
      lowerBound: 0.0,
      upperBound: 2 * pi, // Full sine wave cycle
    )..repeat(); // Repeating the animation

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // Smooth constant speed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ECG Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: ECGPainter(_animation.value),
              size: Size(300, 100), // Set the size of the ECG animation
            );
          },
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



class ECGPainter extends CustomPainter {
  final double progress; // This will be used to control the animation's progress.

  ECGPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green // ECG line color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    double startX = 0.0;
    double startY = size.height / 2;
    path.moveTo(startX, startY);

    // Add points to the path to draw an ECG-like waveform
    for (double i = 0; i < size.width; i++) {
      // Normalize sine wave value to fit within the widget height
      double offset = sin((i + progress) * 0.1) * (size.height / 8);
      path.lineTo(i, startY + offset);
    }

    // Draw the path on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // This will repaint on every frame to animate.
  }
}

