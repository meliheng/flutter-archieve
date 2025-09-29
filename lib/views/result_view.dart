import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  void _onScroll() {
    if (_scrollController.position.pixels > 50) {
      if (_scrollController.offset > 100 && !_isExpanded.value) {
        // _scrollController.jumpTo(100);
      }
      if (!_animationController.isAnimating) {
        _animationController.forward();
        // _animationController2.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationController2 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationController3 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation2 = Tween<double>(
      begin: 0,
      end: 200,
    ).animate(_animationController2);
    _animation3 = Tween<double>(
      begin: 200,
      end: 0,
    ).animate(_animationController3);
    _animation = Tween<double>(
      begin: 200,
      end: 0,
    ).animate(_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // _animationController3.forward();
        Future.delayed(const Duration(milliseconds: 100), () {
          _isExpanded.value = true;
        });
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _animation2,
                      builder: (context, child) {
                        return Container(height: _animation2.value);
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animation.value / 200,
                          child: AnimatedBuilder(
                            animation: _animation3,
                            builder: (context, child) {
                              return Container(
                                height: _animation3.value,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Slider(value: 0.3, onChanged: (value) {}),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text("0:00"), Text("0:00")],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Container(height: 700, color: Colors.blue),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isExpanded,
              builder: (context, value, child) {
                return Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value ? 1 : 0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [Text("Bellie Elish")]),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
