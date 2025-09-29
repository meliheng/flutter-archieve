import 'package:flutter/material.dart';

class CropView extends StatefulWidget {
  const CropView({super.key});

  @override
  State<CropView> createState() => _CropViewState();
}

class _CropViewState extends State<CropView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Image.network(
            "https://picsum.photos/id/237/200/300",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
