import 'dart:async';
import 'package:flutter/material.dart';

class ImageCompareSlider extends StatefulWidget {
  final ImageProvider beforeImage;
  final ImageProvider afterImage;
  final ImageProvider? overlayImage;
  final double? imageHeight;
  final Duration animationDuration;

  const ImageCompareSlider({
    super.key,
    required this.beforeImage,
    required this.afterImage,
    this.overlayImage,
    this.imageHeight,
    this.animationDuration = const Duration(milliseconds: 2000),
  });

  @override
  _ImageCompareSliderState createState() => _ImageCompareSliderState();
}

class _ImageCompareSliderState extends State<ImageCompareSlider>
    with SingleTickerProviderStateMixin {
  double _sliderPosition = 0.5; // Başlangıç pozisyonu (0.0 ile 1.0 arası)
  late AnimationController _animationController;
  late Animation<double> _overlayAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _overlayAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Animasyonu başlat
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: Future.wait([
            _getMinimumAspectRatio(),
            _getMinimumHeight(containerWidth: constraints.maxWidth),
          ]),
          builder: (context, snapshot) {
            // Aspect ratio hesaplanana kadar loading göster
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final aspectRatio = snapshot.data![0];
            final minHeight = snapshot.data![1];
            return AspectRatio(
              aspectRatio: aspectRatio,
              child: SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Alttaki resim (After)
                    // Üstteki, kesilmiş resim (Before)
                    Center(
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: Image(
                          image: widget.beforeImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    ClipRect(
                      clipper: _ImageClipper(clipFactor: _sliderPosition),
                      child: Image(
                        image: widget.afterImage,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Kaydırıcı ve Ayırıcı Çizgi (merkezdeki alan üzerinde)
                    Center(
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: LayoutBuilder(
                          builder: (context, sliderConstraints) {
                            final sliderWidth = sliderConstraints.maxWidth;

                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      setState(() {
                                        // Kaydırma pozisyonunu güncelle
                                        final newPosition =
                                            details.localPosition.dx /
                                            sliderWidth;
                                        _sliderPosition = newPosition.clamp(
                                          0.0,
                                          1.0,
                                        );
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        // Çizgiyi tam ortaya yerleştir
                                        Positioned(
                                          left:
                                              (sliderWidth * _sliderPosition) -
                                              1,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Kaydırıcı Tutamacı
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: (sliderWidth * _sliderPosition) - 25,
                                  child: GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      final newPosition =
                                          _sliderPosition +
                                          (details.delta.dx / sliderWidth);
                                      setState(() {
                                        _sliderPosition = newPosition.clamp(
                                          0.0,
                                          1.0,
                                        );
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.compare_arrows,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(child: Image(image: widget.afterImage)),
                    // Overlay resim - animasyonlu
                    if (widget.overlayImage != null)
                      AspectRatio(
                        aspectRatio: aspectRatio,
                        child: AnimatedBuilder(
                          animation: _overlayAnimation,
                          builder: (context, child) {
                            return ClipRect(
                              clipper: _OverlayClipper(
                                clipFactor: _overlayAnimation.value,
                              ),
                              child: Image(
                                image: widget.overlayImage!,
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<double> _getMinimumAspectRatio() async {
    // Tüm resimlerin aspect ratio'larını hesapla
    final List<Future<double>> aspectRatios = [
      // _getImageAspectRatio(widget.beforeImage),
      _getImageAspectRatio(widget.afterImage),
    ];

    // Overlay resim varsa onu da ekle
    // if (widget.overlayImage != null) {
    //   aspectRatios.add(_getImageAspectRatio(widget.overlayImage!));
    // }

    // Tüm aspect ratio'ları al
    final results = await Future.wait(aspectRatios);

    // En küçük aspect ratio'yu bul
    return results.reduce((a, b) => a < b ? a : b);
  }

  Future<double> _getImageAspectRatio(ImageProvider imageProvider) async {
    final completer = Completer<double>();
    final imageStream = imageProvider.resolve(const ImageConfiguration());

    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo imageInfo, bool _) {
      final image = imageInfo.image;
      final aspectRatio = image.width / image.height;
      completer.complete(aspectRatio);
      imageStream.removeListener(listener);
    });

    imageStream.addListener(listener);
    return completer.future;
  }

  Future<double> _getMinimumHeight({required double containerWidth}) async {
    // Tüm resimlerin height'larını hesapla
    final List<Future<double>> heights = [
      _getImageHeight(widget.beforeImage, containerWidth),
      _getImageHeight(widget.afterImage, containerWidth),
    ];

    // Overlay resim varsa onu da ekle
    if (widget.overlayImage != null) {
      heights.add(_getImageHeight(widget.overlayImage!, containerWidth));
    }

    // Tüm height'ları al
    final results = await Future.wait(heights);

    // En küçük height'ı bul
    return results.reduce((a, b) => a < b ? a : b);
  }

  Future<double> _getImageHeight(
    ImageProvider imageProvider,
    double containerWidth,
  ) async {
    final imageSize = await _getImageSize(imageProvider);
    final aspectRatio = imageSize.width / imageSize.height;
    // Resmi container width'e sığdırırsak height ne olur?
    return containerWidth / aspectRatio;
  }

  Future<Size> _getImageSize(ImageProvider imageProvider) async {
    final completer = Completer<Size>();
    final imageStream = imageProvider.resolve(const ImageConfiguration());

    late ImageStreamListener listener;
    listener = ImageStreamListener((ImageInfo imageInfo, bool _) {
      final image = imageInfo.image;
      completer.complete(Size(image.width.toDouble(), image.height.toDouble()));
      imageStream.removeListener(listener);
    });

    imageStream.addListener(listener);
    return completer.future;
  }
}

// Resmi kesmek için özel bir Clipper sınıfı
class _ImageClipper extends CustomClipper<Rect> {
  final double clipFactor;

  _ImageClipper({required this.clipFactor});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width * clipFactor, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

// Overlay resmi sağdan sola doğru kesmek için özel Clipper sınıfı
class _OverlayClipper extends CustomClipper<Rect> {
  final double clipFactor;

  _OverlayClipper({required this.clipFactor});

  @override
  Rect getClip(Size size) {
    // clipFactor 1.0'dan 0.0'a doğru gidecek
    // clipFactor 1.0 iken tüm resim görünür
    // clipFactor 0.0 iken hiçbir resim görünmez
    final rightEdge = size.width * clipFactor;
    return Rect.fromLTRB(0.0, 0.0, rightEdge, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
