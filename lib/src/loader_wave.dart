import 'package:flutter/material.dart';

class LoaderWave extends StatefulWidget {
  final List<Color> colors;
  final double size;
  final Duration duration;

  const LoaderWave({
    Key? key,
    required this.colors,
    this.size = 60,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(key: key);

  @override
  State<LoaderWave> createState() => _LoaderWaveState();
}

class _LoaderWaveState extends State<LoaderWave> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    final count = widget.colors.length;

    _animations = List.generate(count, (i) {
      final delay = i * 0.1;
      return Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, delay + 0.6, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.colors.length;
    final barWidth = widget.size / (count + (count - 1) * 0.5);

    return SizedBox(
      width: widget.size,
      height: widget.size / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(count, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: _animations[i].value,
                  child: Container(
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: widget.colors[i],
                      borderRadius: BorderRadius.circular(4),
                    ),
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
