import 'package:flutter/material.dart';

class SlideView extends StatefulWidget {
  const SlideView({super.key});

  @override
  State<SlideView> createState() => _SlideViewState();
}

class _SlideViewState extends State<SlideView> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 300) {
        if (!_isExpanded.value) {
          _isExpanded.value = true;
          _fadeController.forward();
          _slideController.forward();
        }
      } else {
        if (_isExpanded.value) {
          _isExpanded.value = false;
          _fadeController.reverse();
          _slideController.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _isExpanded,
        builder: (context, value, child) {
          return SafeArea(
            child: Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Animated container at the top
                      SizedBox(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutCubic,
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            color:
                                _isExpanded.value
                                    ? Colors.transparent
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(
                              _isExpanded.value ? 0 : 20,
                            ),
                            boxShadow: [
                              if (!_isExpanded.value)
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                            ],
                          ),
                          // child:
                          //     _isExpanded.value
                          //         ? null
                          //         : const Center(
                          //           child: Icon(
                          //             Icons.favorite,
                          //             color: Colors.white,
                          //             size: 50,
                          //           ),
                          //         ),
                        ),
                      ),
                      // Content below
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          List.generate(1000, (index) => _text).join(","),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isExpanded.value)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          height: 80,
                          width: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.indigo],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String _text = 'Hello';
