import 'package:anims/image_preview/image_compare_slider.dart';
import 'package:flutter/material.dart';

class ImagePreview2 extends StatelessWidget {
  const ImagePreview2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resim Karşılaştırma')),
      body: Column(
        children: [
          Expanded(
            child: ImageCompareSlider(
              beforeImage: const AssetImage(
                'assets/cat4.jpg',
              ), // Kendi resim yolunuzu yazın
              afterImage: const AssetImage(
                'assets/cat1.jpg',
              ), // Kendi resim yolunuzu yazın
              overlayImage: const AssetImage(
                'assets/cat4.jpg',
              ), // Sayfa açıldığında görünecek overlay resim
              animationDuration: const Duration(milliseconds: 1000),
            ),
          ),
          Container(color: Colors.red, height: 200),
        ],
      ),
    );
  }
}
