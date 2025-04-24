import 'package:flutter/material.dart';

class NewtonsCradle extends StatefulWidget {
  @override
  _NewtonsCradleState createState() => _NewtonsCradleState();
}

class _NewtonsCradleState extends State<NewtonsCradle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _animations = [];
  final int _ballCount = 5;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Create staggered animations for each ball
    for (int i = 0; i < _ballCount; i++) {
      final animation = Tween<double>(begin: 0, end: i == 0 ? -0.3 : 0.3).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            i * 0.1,
            1.0 - i * 0.1,
            curve: Curves.easeInOutSine,
          ),
        ),
      );
      _animations.add(animation);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_ballCount, (index) {
              return _buildPendulumBall(
                angle: _animations[index].value,
                isFirst: index == 0,
                isLast: index == _ballCount - 1,
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildPendulumBall({
    required double angle,
    required bool isFirst,
    required bool isLast,
  }) {
    return Transform.rotate(
      angle: angle,
      alignment: Alignment.topCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Suspension wire
          Container(
            width: 2,
            height: 200,
            color: Colors.grey[800],
          ),
          // Ball with shadow
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}