import 'dart:math';

import 'package:boats/components/entitiy.dart';
import 'package:boats/components/ship_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:vector_math/vector_math_64.dart';

import 'base_hex_widget.dart';
import 'hex_coords.dart';

class ScrollableHexGrid extends StatefulWidget {
  final Matrix4 xForm;
  final Vector3 translation = Vector3.zero();
  final Quaternion rotation = Quaternion.identity();
  final Vector3 scale = Vector3.zero();

  final Map<Point, Entity> entities;
  final int hexSize;
  final double containerWidth;
  final double containerHeight;
  final List<Widget> overlays;

  ScrollableHexGrid({
    @required this.entities,
    @required this.hexSize,
    @required this.xForm,
    @required this.containerWidth,
    @required this.containerHeight,
    @required this.overlays
  }) {
    xForm.decompose(translation, rotation, scale);
  }

  @override
  State<StatefulWidget> createState() => ScrollableHexGridState();
}

class ScrollableHexGridState extends State<ScrollableHexGrid> {

  int get hexSize => widget.hexSize;
  Vector3 get scale => widget.scale;
  Vector3 get translation => widget.translation;

  double get containerWidth => widget.containerWidth;
  double get containerHeight => widget.containerHeight;

  @override
  void initState() {
    super.initState();
  }

  List<Hex> getHexes(Hex centerHex, int radius) {
    List<Hex> hexList = [];
    hexList.add(centerHex);
    hexList.add(centerHex.neighbor(0));
    //Start at one since we already seeded the origin
    Hex neighborHex = centerHex;
    for (int orbital = 1; orbital < radius; orbital++) {
      neighborHex = neighborHex.neighbor(0);
      for (int direction = 0; direction < Hex.directions.length; direction++) {
        for (int o = 0; o < orbital; o++) {
          hexList.add(neighborHex);
          neighborHex =
            neighborHex.neighbor((direction + 2) % Hex.directions.length);
        }
      }
    }
    return hexList;
  }

  @override
  Widget build(BuildContext b) => buildStack(b);

  Widget buildStack(BuildContext b) {
    final scaledHexSize = hexSize * scale.x;

    //NOTE: this appears to cause issues with determining the center hex
//    final size = HexLayout.getOrientFlatSizeFromSymmetricalSize(scaledHexSize);
    final size = Point(scaledHexSize, scaledHexSize);
    final layout = HexLayout.orientFlat(size);
    final Point zero = Point(-translation.x,-translation.y);

    //origin of view
    final centerHex = Hex.fromPoint(layout, zero);

    final containerMiddle = Point(containerWidth/2, containerHeight/2);
    final edgeHex = Hex.fromPoint(layout, zero+containerMiddle);
    final hexRadius = centerHex.distance(edgeHex);

    final List<Hex> hexes = getHexes(centerHex, hexRadius);

    Widget positioned(Hex hex, Widget child) {
      final hexToPixel = hex.toPixel(layout)+containerMiddle;
      return Positioned(
        left: hexToPixel.x+translation.x,
        top: hexToPixel.y+translation.y,
        child: child
      );
    }

    Widget hexToWidget(Hex h) => positioned(h,
        BaseHexWidget(
          q: h.q,
          r: h.r,
          s: h.s,
          size: size,
          layout: layout
        )
      );

    Widget mark(Point p, Color c, double w, {double h}) => Positioned(
      top: p.y-(h??w)/2,
      left: p.x-w/2,
      child: Container(color: c, width: w, height: h ?? w)
    );
    Widget debug(List<String> lines) => Positioned(
      bottom:10,
      left:10,
      child: Container(
        color: m.Colors.white,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines.map((l) => Text(l)).toList())
          )
        )
      );

    final entities = hexes
      .where((h)=> widget.entities[Point<num>(h.q, h.r)] != null)
      .map((h) => positioned(
        h,
        widget.entities[Point<num>(h.q, h.r)].render(context, size)
      ));
    final heading = (widget.entities.values.first as ShipEntity).heading;

    return Stack(
      fit: StackFit.loose,
      children:
        hexes.map(hexToWidget).toList() +
        entities.toList() +
        [
          mark(
            containerMiddle,
            m.Colors.red,
            3
          ),
          mark(
            containerMiddle,
            m.Colors.green.withOpacity(0.5),
            size.x*2, h: size.y*2
          ),
          debug([
            "centerHex: ${centerHex.q}, ${centerHex.r}, ${centerHex.s}",
            "translation: $translation",
            "scale: $scale",
            "radius: $hexRadius",
            "size: $size",
            "heading: ${heading}"
          ])
        ]
      + widget.overlays
    );
  }
}