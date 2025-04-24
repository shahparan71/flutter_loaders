import 'package:flutter/material.dart';

class LoaderBounce extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const LoaderBounce({
    Key? key,
    this.color = Colors.orange,
    this.size = 50,
    this.duration = const Duration(milliseconds: 900),
  }) : super(key: key);

  @override
  State<LoaderBounce> createState() => _LoaderBounceState();
}

class _LoaderBounceState extends State<LoaderBounce> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat(reverse: true);
    _animations = List.generate(3, (i) {
      return Tween<double>(begin: 0, end: -widget.size * 0.4).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(i * 0.2, i * 0.2 + 0.6, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 5;

    return SizedBox(
      height: widget.size / 2,
      width: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.translate(
                offset: Offset(0, _animations[i].value),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                  ),
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
