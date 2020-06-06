
import 'dart:ui';

import 'package:flutter/material.dart';

class HexBorderPainter extends CustomPainter {
  final List<Offset> corners;
  final Color colour;
  HexBorderPainter(this.corners, this.colour);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.polygon;

    final paint = Paint()
      ..color = colour
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, corners + [corners.first], paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}