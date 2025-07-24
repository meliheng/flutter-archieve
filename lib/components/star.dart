import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  const Star({super.key});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _sizeAnimation = Tween<double>(begin: 40, end: 70).animate(_controller);
    _colorAnimation = ColorTween(
      begin: Colors.amber,
      end: Colors.white,
    ).animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Icon(
          Icons.star,
          color: _colorAnimation.value,
          size: _sizeAnimation.value,
        );
      },
    );
  }
}
