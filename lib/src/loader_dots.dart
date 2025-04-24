import 'package:flutter/material.dart';

class LoaderDots extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const LoaderDots({
    Key? key,
    this.color = Colors.blue,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(key: key);

  @override
  State<LoaderDots> createState() => _LoaderDotsState();
}

class _LoaderDotsState extends State<LoaderDots> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _animations = List.generate(3, (i) {
      final start = i * 0.2;
      final end = start + 0.6;
      return Tween(begin: 0.0, end: -widget.size * 0.3).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 5;

    return SizedBox(
      width: widget.size,
      height: widget.size / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.translate(
                offset: Offset(0, _animations[i].value),
                child: Dot(
                  color: widget.color,
                  size: dotSize,
                ),
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double size;
  final Color color;

  const Dot({Key? key, required this.size, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
