import 'package:anims/views/brush_controller.dart';
import 'package:anims/views/stroke.dart';
import 'package:flutter/material.dart';

class BrushPage extends StatefulWidget {
  const BrushPage({
    super.key,
    required this.width,
    required this.height,
    required this.brushColor,
    required this.initialBrushSize,
    required this.controller,
  });
  final double width;
  final double height;
  final Color brushColor;
  final double initialBrushSize;
  final BrushController controller;

  @override
  State<BrushPage> createState() => _BrushPageState();
}

class _BrushPageState extends State<BrushPage> {
  final GlobalKey _paintKey = GlobalKey();
  double brushSize = 6.0;
  Stroke? currentStroke;
  @override
  void initState() {
    super.initState();
    brushSize = widget.initialBrushSize;
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brush Çizim")),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: () {
                  setState(() {
                    widget.controller.undo(); // 🎯 Son çizimi tamamen sil
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          RepaintBoundary(
            key: _paintKey,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: GestureDetector(
                onPanStart: (details) {
                  if (details.localPosition.dy <= widget.height) {
                    final stroke = Stroke(
                      points: [details.localPosition],
                      strokeWidth: brushSize,
                      color: widget.brushColor,
                    );
                    currentStroke = stroke;
                    widget.controller.addStroke(stroke);
                    setState(() {});
                  }
                },
                onPanUpdate: (details) {
                  if (details.localPosition.dy <= widget.height) {
                    currentStroke?.points.add(details.localPosition);
                    setState(() {});
                  }
                },
                onPanEnd: (details) {
                  currentStroke = null;
                  setState(() {});
                },
                child: CustomPaint(
                  painter: BrushPainter(strokes: widget.controller.strokes),
                  size: Size(widget.width, widget.height),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Text("Fırça Kalınlığı"),
                Slider(
                  value: brushSize,
                  min: 1.0,
                  max: 30.0,
                  divisions: 29,
                  label: brushSize.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      brushSize = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: kBottomNavigationBarHeight + 40.0),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() => points.clear()),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}

class BrushPainter extends CustomPainter {
  final List<Stroke> strokes;

  BrushPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    for (var stroke in strokes) {
      final paint =
          Paint()
            ..color = stroke.color
            ..strokeWidth = stroke.strokeWidth
            ..strokeCap = StrokeCap.round;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
