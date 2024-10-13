// ignore_for_file: unused_field

import 'dart:ui';

import 'package:flutter_cgm/src/cgm/cgm.dart';

class ColorTable extends Command {
  late final int _startIndex;
  late final List<Color> _colors;

  ColorTable(super.ec, super.eid, super.l, super.buffer, super.cgm) {
    _startIndex = makeColorIndex();

    final n = (arguments.length - currentArgument) / sizeOfDirectColor();
    _colors = List.generate(n.round(), (_) => makeDirectColor());
  }

  @override
  void paint(CGMDisplay display) {
    for (int i = 0; i < _colors.length; i++) {
      display.setIndexedColor(_startIndex + i, _colors[i]);
    }

    if (display.isBeforeBeginPicture) {
      final extent = display.extent;
      final color = display.getIndexedColor(0);
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      display.canvas.drawRect(Rect.fromLTRB(extent[0].x, extent[0].y, extent[1].x, extent[1].y), paint);
    }
  }

  @override
  String toString() => 'ColorTable -> { '
      'start: $_startIndex } '
      'colors: [ ${_colors.join(', ')} ]';
}
