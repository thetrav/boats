import 'dart:math';
import 'package:flutter/material.dart';

import 'entitiy.dart';
import '../game/ship.dart';

const turnAngle = 1.0472;

class ShipEntity extends Entity {
  final Ship ship;

  String get image => "assets/images/${ship.shipClass} MS.png";
  int get heading => ship.heading;

  ShipEntity(this.ship);

  @override
  Widget render(BuildContext c, Point size) {
    final transform = Matrix4.identity()
      ..rotateZ(turnAngle*heading)
      ..translate(-size.x / 2, -size.y / 2, 0);
    return Container(
      transform: transform,
      alignment: Alignment.center,
      child: Image.asset(image,
        fit: BoxFit.fill,
        width: size.x,
        height: size.y * 3,
      )
    );
  }
}
