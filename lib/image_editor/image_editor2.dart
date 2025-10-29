import 'package:anims/image_editor/overlay_widget.dart';
import 'package:flutter/material.dart';

class ImageEditor2 extends StatefulWidget {
  const ImageEditor2({super.key});

  @override
  State<ImageEditor2> createState() => _ImageEditor2State();
}

class _ImageEditor2State extends State<ImageEditor2>
    with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    print("state: $state");
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.asset("assets/cat3.jpg", fit: BoxFit.cover),
                  ),
                  OverlayWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
