import 'dart:typed_data';
import 'dart:ui';

import 'package:anims/views/stroke.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BrushController extends ChangeNotifier {
  final List<Stroke> _strokes = [];
  final List<Stroke> _redoStack = [];

  List<Stroke> get strokes => List.unmodifiable(_strokes);

  void addStroke(Stroke stroke) {
    _strokes.add(stroke);
    _redoStack.clear(); // Yeni çizim yapılırsa redo geçmişi silinir
    notifyListeners();
  }

  void undo() {
    if (_strokes.isNotEmpty) {
      _redoStack.add(_strokes.removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _strokes.add(_redoStack.removeLast());
      notifyListeners();
    }
  }

  void clear() {
    _strokes.clear();
    _redoStack.clear();
    notifyListeners();
  }

  Future<Uint8List?> getFile(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // PNG olarak kaydedildi. Şimdi galeriye kaydetmek istersen aşağıdaki gibi kullanabilirsin.
      debugPrint(
        "PNG başarıyla oluşturuldu. Bayt uzunluğu: ${pngBytes.length}",
      );
      return pngBytes;

      // Kaydetmek istersen örneğin `image_gallery_saver` kullan:
      // final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "my_drawing");
    } catch (e) {
      debugPrint("Resim kaydetme hatası: $e");

      return null;
    }
  }
}
