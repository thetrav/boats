import 'dart:math';
import 'package:boats/game/headings.dart';
import 'package:boats/game/sail_state.dart';
import 'package:flutter/material.dart';

import 'entitiy.dart';
import '../game/ship.dart';

const turnAngle = 1.0472;

class ShipEntity extends Entity {
  final Ship ship;

  String get sail => ship.sail == DOWN || ship.sail == FIGHTING ? "FS" : "MS";

  String get image => "assets/images/${ship.shipClass} ${sail}.png";
  String get fsCounter => "assets/images/plainsail.png";
  Heading get heading => ship.heading;

  ShipEntity(this.ship);

  @override
  Widget render(BuildContext c, Point size) {
    final transform = Matrix4.identity()
      ..rotateZ(turnAngle*heading.index)
      ..translate(-size.x / 2, -size.y / 2, 0);
    return Container(
      transform: transform,
      alignment: Alignment.center,
      width: size.x,
      height: size.y*3,
      child: Stack(
        children: [
          Positioned(
            top: 0, left: 0,
            child: Image.asset(image,
              fit: BoxFit.fill,
              width: size.x,
              height: size.y * 3,
            )
          ),
          Positioned(
            top:size.x,
            left:0,
            child: Image.asset(fsCounter,
              fit: BoxFit.fill,
              width: size.x,
              height: size.y
            )
          )
        ]
      )
    );
  }
}
