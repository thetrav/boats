
import 'dart:math';

import 'package:flutter/material.dart';

import 'hex_border_painter.dart';
import 'hex_coords.dart';

class BaseHexWidget extends StatelessWidget {

  HexLayout layout;
  final Point size;
  final int q;
  final int r;
  final int s;

  BaseHexWidget({
    this.size,
    this.q,
    this.r,
    this.s,
    this.layout
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
      painter: HexBorderPainter(corners, Colors.black),
      child: Container(
        transform: Matrix4.translationValues(-size.x/2, -size.y/2, 1),
        alignment: Alignment.center,
        width: size.x,
        height: size.y,
        child: Text("$q, $r, $s", textScaleFactor: 0.8)
      )
    );
  }
}