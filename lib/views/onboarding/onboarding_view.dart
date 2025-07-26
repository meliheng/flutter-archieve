import 'dart:async';

import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final ScrollController _scrollController = ScrollController();
  final List<String> images = List.generate(10, (i) {
    if (i % 3 == 0) return 'assets/cat3.jpg';
    return 'assets/cat1.jpg';
  });
  late Timer _scrollTimer;
  final double _scrollSpeed = 1.0; // Piksel cinsinden scroll hızı
  String getImage(int index) {
    if (index % 3 == 0) return 'assets/cat3.jpg';
    if (index % 2 == 0) return 'assets/cat2.jpg';
    return 'assets/cat1.jpg';
  }

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(Duration(milliseconds: 16), (_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (currentScroll < maxScroll) {
          _scrollController.jumpTo(currentScroll + _scrollSpeed);
        } else {
          // En sona gelince başa dön
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        children: [
          SizedBox(
            height: 600,
            child: Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(getImage(index), fit: BoxFit.cover),
                    );
                  },
                ),
                // Alt gölge efekti
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100, // gölge yüksekliği
                  child: IgnorePointer(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87, // veya Colors.black54
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
)
;
  }
}
