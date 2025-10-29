import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final String beforeImagePath;
  final String afterImagePath;

  const ImagePreview({
    super.key,
    required this.beforeImagePath,
    required this.afterImagePath,
  });

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  double _sliderPosition =
      0.5; // 0.0 = sol resim tamamen görünür, 1.0 = sağ resim tamamen görünür

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resim Karşılaştırma'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0, // Kare format
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Sol resim (Öncesi)
                  Positioned.fill(
                    child: Image.asset(
                      widget.beforeImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Sağ resim (Sonrası) - sadece belirli kısmı görünür
                  Positioned.fill(
                    child: ClipRect(
                      clipper: _CustomClipper(_sliderPosition),
                      child: Image.asset(
                        widget.afterImagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Sürüklenebilir çizgi
                  Positioned(
                    left:
                        MediaQuery.of(context).size.width * _sliderPosition - 1,
                    top: 0,
                    bottom: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Çizgi
                        Container(
                          width: 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        // Ortadaki yuvarlak sürükleme butonu
                        Positioned(
                          left: -20,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Listener(
                              onPointerDown: (details) {
                                print("onPointerDown: ${details.position.dx}");
                              },
                              onPointerMove: (details) {
                                print("onPointerMove: ${details.position.dx}");
                                setState(() {
                                  final screenWidth = MediaQuery.of(
                                    context,
                                  ).size.width;
                                  final newPosition =
                                      details.position.dx / screenWidth;
                                  _sliderPosition = newPosition.clamp(0.0, 1.0);
                                });
                              },
                              onPointerUp: (details) {
                                print("onPointerUp");
                              },
                              child: GestureDetector(
                                onTap: () {
                                  print("onTap:");
                                },
                                onPanStart: (details) {
                                  print("onPanStart:");
                                },
                                onPanUpdate: (details) {
                                  print(
                                    "onPanUpdate: ${details.globalPosition.dx}",
                                  );
                                  setState(() {
                                    final screenWidth = MediaQuery.of(
                                      context,
                                    ).size.width;
                                    final newPosition =
                                        details.globalPosition.dx / screenWidth;
                                    _sliderPosition = newPosition.clamp(
                                      0.0,
                                      1.0,
                                    );
                                  });
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.drag_indicator,
                                    color: Colors.black,
                                    size: 20,
                                  ),
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
        ),
      ),
    );
  }
}

// Özel clipper sınıfı - sağ resmin sadece belirli kısmını göstermek için
class _CustomClipper extends CustomClipper<Rect> {
  final double position;

  _CustomClipper(this.position);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(size.width * position, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return oldClipper is _CustomClipper && oldClipper.position != position;
  }
}
