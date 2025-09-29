import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final ValueNotifier<bool> _isSelected = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image View')),
      body: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                print("ontap");
                _isSelected.value = !_isSelected.value;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/cat3.jpg',
                  fit: BoxFit.cover,
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _isSelected,
              builder: (context, value, child) {
                if (value) {
                  return Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
