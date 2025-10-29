import 'package:flutter/material.dart';

class CustomMatrix extends StatefulWidget {
  final Widget child;
  final ValueChanged<Matrix4>? onMatrixUpdate;
  final Matrix4? initialMatrix;

  const CustomMatrix({
    super.key,
    required this.child,
    this.onMatrixUpdate,
    this.initialMatrix,
  });

  @override
  State<CustomMatrix> createState() => _MatrixGestureDetectorState();
}

class _MatrixGestureDetectorState extends State<CustomMatrix> {
  Matrix4 translationDeltaMatrix = Matrix4.identity();
  Matrix4 matrix = Matrix4.identity();
  Offset oldValue = Offset.zero;
  _ValueUpdater<Offset> translationUpdater = _ValueUpdater(
    onUpdate: (oldVal, newVal) => newVal - (oldVal ?? Offset.zero),
  );
  @override
  void initState() {
    super.initState();
  }

  void _handleScaleStart(ScaleStartDetails details) {
    translationUpdater.value = details.focalPoint;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    translationDeltaMatrix = Matrix4.identity();
    Offset translationDelta = translationUpdater.update(details.focalPoint);
    var dx = translationDelta.dx;
    var dy = translationDelta.dy;
    translationDeltaMatrix = Matrix4(
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      dx,
      dy,
      0,
      1,
    );
    matrix = matrix * translationDeltaMatrix;
    widget.onMatrixUpdate?.call(matrix);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      child: widget.child,
    );
  }
}

typedef _OnUpdate<T> = T Function(T? oldValue, T newValue);

class _ValueUpdater<T> {
  final _OnUpdate<T> onUpdate;
  T? value;

  _ValueUpdater({required this.onUpdate});

  T update(T newValue) {
    T updated = onUpdate(value, newValue);
    value = newValue;
    return updated;
  }
}
