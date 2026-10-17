import 'dart:io';
import 'dart:ui' as ui;

import 'package:terrace_garden/core/storage/photo_storage.dart';

/// Writes a real PNG of the given size (for code that reads image headers).
/// Must run inside `tester.runAsync` in widget tests.
Future<File> writeTestPng(String path, {int width = 4, int height = 3}) async {
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder).drawRect(
    ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    ui.Paint()..color = const ui.Color(0xFF2F5D3A),
  );
  final image = await recorder.endRecording().toImage(width, height);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  final file = File(path);
  await file.parent.create(recursive: true);
  return file.writeAsBytes(bytes!.buffer.asUint8List());
}

/// Copies instead of re-encoding, so storage logic runs on the host.
class CopyingImageCompressor implements ImageCompressor {
  int calls = 0;
  bool fail = false;

  @override
  Future<void> compress(
    String source,
    String target, {
    required int maxShortSide,
    required int quality,
  }) async {
    calls++;
    if (fail) throw const FileSystemException('compression failed');
    await File(source).copy(target);
  }
}
