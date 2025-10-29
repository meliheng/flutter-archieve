import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Matrix4> notifier = ValueNotifier<Matrix4>(
      Matrix4.identity(),
    );
    return MatrixGestureDetector(
      onMatrixUpdate:
          (
            matrix,
            translationDeltaMatrix,
            scaleDeltaMatrix,
            rotationDeltaMatrix,
          ) {
            notifier.value = matrix;
          },
      child: AnimatedBuilder(
        animation: notifier,
        builder: (ctx, child) {
          return Transform(
            transform: notifier.value,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset("assets/cat2.jpg"),
            ),
          );
        },
      ),
    );
  }
}
