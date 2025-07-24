import 'package:flutter/material.dart';

class Stroke {
  final List<Offset> points;
  final double strokeWidth;
  final Color color; // opsiyonel, ileride lazım olur

  Stroke({
    required this.points,
    required this.strokeWidth,
    this.color = Colors.blue,
  });
}
