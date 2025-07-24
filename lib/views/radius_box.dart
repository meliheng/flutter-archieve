import 'package:flutter/material.dart';

class RadiusBox extends StatefulWidget {
  const RadiusBox({super.key});

  @override
  State<RadiusBox> createState() => _RadiusBoxState();
}

class _RadiusBoxState extends State<RadiusBox> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double?> _radiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _radiusAnimation = Tween<double>(begin: 0, end: 100).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(_radiusAnimation.value!),
            ),
            width: 200,
            height: 200,
          );
        },
      ),
    );
  }
}
