import 'package:flutter/material.dart';

class LoaderCube extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const LoaderCube({
    Key? key,
    this.color = Colors.blue,
    this.size = 50,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(key: key);

  @override
  State<LoaderCube> createState() => _LoaderCubeState();
}

class _LoaderCubeState extends State<LoaderCube> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          final rotate = _animation.value * 3.14;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(rotate)..rotateZ(rotate),
            child: Container(
              width: widget.size,
              height: widget.size,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
