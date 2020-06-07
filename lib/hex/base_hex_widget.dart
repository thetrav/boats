
import 'dart:math';

import 'package:flutter/material.dart';

import 'hex_border_painter.dart';
import 'hex_coords.dart';

class BaseHexWidget extends StatelessWidget {

  final HexLayout layout;
  final Point size;
  final Hex hex;
  final Color color;
  final bool drawCoords;

  BaseHexWidget({
    this.hex,
    this.size,
    this.layout,
    this.color = Colors.black,
    this.drawCoords = true
  });

  @override
  Widget build(BuildContext context) {
    final identityHex = Hex(0,0);
    final corners = List<int>.generate(6, (i) => i).map((i) {
      final offset = identityHex.cornerOffset(layout, i);
      return Offset(offset.x, offset.y);
    }).toList();
    return CustomPaint(
      size: Size(size.x, size.y),
      painter: HexBorderPainter(corners, color),
      child: Container(
        transform: Matrix4.translationValues(-size.x/2, -size.y/2, 1),
        alignment: Alignment.center,
        width: size.x,
        height: size.y,
        child: drawCoords ?
          Text("${hex.q}, ${hex.r}, ${hex.s}", textScaleFactor: 0.8) :
          null
      )
    );
  }
}