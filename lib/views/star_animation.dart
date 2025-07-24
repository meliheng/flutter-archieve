import 'package:anims/components/star.dart';
import 'package:flutter/material.dart';

class StarAnimation extends StatefulWidget {
  const StarAnimation({super.key});

  @override
  State<StarAnimation> createState() => _StarAnimationState();
}

class _StarAnimationState extends State<StarAnimation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(5, (index) {
            return const Star();
          }),
        ],
      ),
    );
  }
}
