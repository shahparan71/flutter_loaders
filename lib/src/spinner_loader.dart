import 'package:flutter/material.dart';
import 'dart:math';

class SpinnerLoader extends StatefulWidget {
  final double size;
  final Color color;

  const SpinnerLoader({super.key, this.size = 100.0, this.color = Colors.grey});

  @override
  State<SpinnerLoader> createState() => _SpinnerLoaderState();
}

class _SpinnerLoaderState extends State<SpinnerLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final int _dotCount = 8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double radius = widget.size / 2.5;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(_dotCount, (i) {
              final double angle = (2 * pi / _dotCount) * i;
              final double opacityFactor = (i + (_controller.value * _dotCount)) % _dotCount / _dotCount;

              return Transform.rotate(
                angle: angle,
                child: Transform.translate(
                  offset: Offset(0, -radius),
                  child: Opacity(
                    opacity: opacityFactor,
                    child: Container(
                      width: widget.size * 0.12,
                      height: widget.size * 0.25,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
