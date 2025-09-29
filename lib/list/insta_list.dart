import 'package:flutter/material.dart';

class InstaList extends StatefulWidget {
  const InstaList({super.key});

  @override
  State<InstaList> createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  final PageController _pageController = PageController(viewportFraction: 0.2);
  int _currentIndex = 0;
  double _scrollOffset = 0.0;
  bool _isAnimating = false;

  // Sample effect data
  final List<EffectData> effects = [
    EffectData(name: 'Normal', color: Colors.grey[300]!, icon: Icons.circle),
    EffectData(
      name: 'Clarendon',
      color: Colors.blue[200]!,
      icon: Icons.wb_sunny,
    ),
    EffectData(
      name: 'Gingham',
      color: Colors.pink[200]!,
      icon: Icons.auto_fix_high,
    ),
    EffectData(
      name: 'Moon',
      color: Colors.purple[200]!,
      icon: Icons.nightlight_round,
    ),
    EffectData(
      name: 'Lark',
      color: Colors.orange[200]!,
      icon: Icons.wb_incandescent,
    ),
    EffectData(name: 'Reyes', color: Colors.brown[200]!, icon: Icons.landscape),
    EffectData(name: 'Juno', color: Colors.red[200]!, icon: Icons.favorite),
    EffectData(
      name: 'Slumber',
      color: Colors.indigo[200]!,
      icon: Icons.bedtime,
    ),
    EffectData(name: 'Crema', color: Colors.amber[200]!, icon: Icons.coffee),
    EffectData(name: 'Ludwig', color: Colors.teal[200]!, icon: Icons.brush),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content area
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: effects[_currentIndex].color.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      effects[_currentIndex].icon,
                      size: 80,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      effects[_currentIndex].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Effect selector at the bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              child: Stack(
                children: [
                  // Empty circle in the center
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),

                  // Scrollable effects
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      if (!_isAnimating) {
                        setState(() {
                          _currentIndex = index;
                        });
                      }
                    },
                    itemCount: effects.length,
                    itemBuilder: (context, index) {
                      // Calculate distance from current index
                      final distance = (index - _currentIndex).abs();

                      // Size based on distance from current index, but only if not animating
                      final size =
                          (!_isAnimating && distance <= 1)
                              ? 50.0
                              : 40.0; // 3 items (current + 2 neighbors) = 50px, others = 40px
                      final iconSize =
                          (!_isAnimating && distance <= 1) ? 24.0 : 20.0;

                      return GestureDetector(
                        onTap: () {
                          _isAnimating = true;
                          _pageController
                              .animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              )
                              .then((_) {
                                _isAnimating = false;
                                setState(() {
                                  _currentIndex = index;
                                });
                              });
                        },
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: effects[index].color,
                            ),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              style: TextStyle(fontSize: iconSize),
                              child: Icon(
                                effects[index].icon,
                                color: Colors.white,
                                size: iconSize,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Effect names below
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        effects[_currentIndex].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EffectData {
  final String name;
  final Color color;
  final IconData icon;

  EffectData({required this.name, required this.color, required this.icon});
}
