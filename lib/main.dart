import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexagonal_grid/hexagonal_grid.dart';
import 'package:hexagonal_grid_widget/hex_grid_child.dart';
import 'package:hexagonal_grid_widget/hex_grid_context.dart';
import 'package:hexagonal_grid_widget/hex_grid_widget.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Boats!',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        headline: TextStyle(
          color: Colors.blue,
          fontSize: 18.0,
        ),
      ),
    ),
    home: HexGridWidgetExample(),
  );
}

class HexGridWidgetExample extends StatelessWidget {
  final double hexSize = 48;
  final double _velocityFactor = 0.3;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        centerTitle: true,
      ),
      body: HexGridWidget(
        children: (q,r,s) => ExampleHexGridChild(),
        hexGridContext: HexGridContext(hexSize, _velocityFactor)));
}

class ExampleHexGridChild extends HexGridChild {

  ExampleHexGridChild();

  @override
  Widget toHexWidget(BuildContext context, HexGridContext hexGridContext, Hex hex) {
    final size = Point(hexGridContext.size, hexGridContext.size);
    final identityHex = Hex(0,0);
    final identityLayout = HexLayout(size, Point(0,0));
    final corners = List<int>.generate(6, (i) => i).map((i) {
      final offset = identityHex.cornerOffset(identityLayout, i);
      return Offset(offset.x, offset.y);
    }).toList();
    final hexSize = HexLayout.getOrientFlatSizeFromSymmetricalSize(hexGridContext.size);
    return CustomPaint(
      size: Size(hexSize.x, hexSize.y),
      painter: HexBorderPainter(corners, Colors.black),
      child: Container(
        transform: Matrix4.translationValues(-hexSize.x/2, -hexSize.y/2, 1),
        alignment: Alignment.bottomCenter,
        width: hexSize.x,
        height: hexSize.y,
        child: Text("${hex.q}, ${hex.r}, ${hex.s}", textScaleFactor: 0.8)
      )
    );
  }
}

class HexBorderPainter extends CustomPainter {
  final List<Offset> corners;
  final Color colour;
  HexBorderPainter(this.corners, this.colour);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = PointMode.polygon;

    final paint = Paint()
      ..color = colour
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, corners + [corners.first], paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
