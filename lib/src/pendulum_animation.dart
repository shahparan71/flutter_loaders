import 'package:flutter/material.dart';

class PendulumAnimation extends StatefulWidget {
  @override
  _PendulumAnimationState createState() => _PendulumAnimationState();
}

class _PendulumAnimationState extends State<PendulumAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.3, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              // Pendulum string
              Container(
                width: 2,
                height: 200,
                color: Colors.black,
              ),
              // Pendulum bob
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}