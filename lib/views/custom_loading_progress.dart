import 'package:flutter/material.dart';

class CustomLoadingProgress extends StatefulWidget {
  const CustomLoadingProgress({super.key});

  @override
  State<CustomLoadingProgress> createState() => _CustomLoadingProgressState();
}

class _CustomLoadingProgressState extends State<CustomLoadingProgress>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..forward();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: _animation.value * 300,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
