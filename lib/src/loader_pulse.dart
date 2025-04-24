import 'package:flutter/material.dart';

class LoaderPulse extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const LoaderPulse({
    Key? key,
    this.color = Colors.pink,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  State<LoaderPulse> createState() => _LoaderPulseState();
}

class _LoaderPulseState extends State<LoaderPulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat(reverse: true);
    _animation = Tween(begin: 0.7, end: 1.2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
