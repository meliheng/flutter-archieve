import 'package:flutter/material.dart';

class ColoredContainer extends StatefulWidget {
  const ColoredContainer({super.key});

  @override
  State<ColoredContainer> createState() => _ColoredContainerState();
}

class _ColoredContainerState extends State<ColoredContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Container(
            width: 200,
            height: 200,
            color: _colorAnimation.value,
          );
        },
      ),
    );
  }
}
