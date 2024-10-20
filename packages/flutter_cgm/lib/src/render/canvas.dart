import 'dart:typed_data';
import 'dart:ui';

import 'package:cgm/cgm.dart';
import 'package:flutter_cgm/src/render/render.dart';
import 'package:vector_math/vector_math.dart';

import 'package:cgm/color.dart' as color;

class FlutterCGMCanvas extends CGMCanvas {
  final Canvas canvas;

  final String? fontFamily;

  FlutterCGMCanvas(this.canvas, {this.fontFamily});

  @override
  void clipPath(CGMPath path) => canvas.clipPath((path as FlutterCGMPath).getPath());

  @override
  CGMPath createPath([CGMPath? copyFrom]) => FlutterCGMPath((copyFrom as FlutterCGMPath?)?.getPath());

  @override
  void drawCircle(Vector2 center, double radius, CGMPaint paint) =>
      canvas.drawCircle(Offset(center.x, center.y), radius, paint.toPaint());

  @override
  void drawPath(CGMPath path, CGMPaint paint) => canvas.drawPath((path as FlutterCGMPath).getPath(), paint.toPaint());

  @override
  void drawRect(Vector2 position, Vector2 size, CGMPaint paint) =>
      canvas.drawRect(Rect.fromLTWH(position.x, position.y, size.x, size.y), paint.toPaint());

  @override
  void drawText(String text, {required Vector2 offset, color.Color color = const color.Color(0xFF000000)}) {
    final builder = ParagraphBuilder(ParagraphStyle());
    builder.pushStyle(TextStyle(
      color: Color(color.value),
      fontFamily: fontFamily,
    ));
    builder.addText(text);

    final paragraph = builder.build();
    paragraph.layout(const ParagraphConstraints(width: double.infinity));

    canvas.drawParagraph(paragraph, Offset(offset.x, offset.y));
  }

  @override
  LineMetrics getLineMetrics(String text) {
    final builder = ParagraphBuilder(ParagraphStyle());
    builder.addText(text);

    final paragraph = builder.build();
    paragraph.layout(const ParagraphConstraints(width: double.infinity));

    final metrics = paragraph.getLineMetricsAt(0);
    if (metrics == null) return LineMetrics.empty();

    return LineMetrics(
      ascent: metrics.ascent,
      descent: metrics.descent,
      baseline: metrics.baseline,
      height: metrics.height,
    );
  }

  @override
  void restore() => canvas.restore();

  @override
  void save() => canvas.save();

  @override
  void scale(double x, double y) => canvas.scale(x, y);

  @override
  void transform(Float64List matrix4) => canvas.transform(matrix4);

  @override
  void translate(double x, double y) => canvas.translate(x, y);
}
