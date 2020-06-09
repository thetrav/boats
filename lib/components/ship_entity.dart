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
  String get plainSail => "assets/images/plainsail.png";
  String get menInRigging => "assets/images/meninrigging.png";
  Heading get heading => ship.heading;

  ShipEntity(this.ship);

  @override
  Widget render(BuildContext c, Point size) {
    final transform = Matrix4.identity()
      ..rotateZ(turnAngle*heading.index)
      ..translate(-size.x / 2, -size.y / 2, 0);
    final counters = <String>[];
    if(ship.sail == PLAIN) {
      counters.add(plainSail);
      if(ship.previousTurn?.plan?.sailChange==MEDIUM) {
        counters.add(menInRigging);
      }
    }
    if(ship.sail == MEDIUM && ship?.previousTurn?.plan.sailChange==PLAIN) {
      counters.add(menInRigging);
    }

    final counterWidgets = <Widget>[];
    counters.asMap().forEach((i, c) =>
      counterWidgets.add(Positioned(
        top:size.x * i,
        left:0,
        child: Image.asset(c,
          fit: BoxFit.fill,
          width: size.x,
          height: size.y
        )
      ))
    );

    return Container(
      transform: transform,
      alignment: Alignment.center,
      width: size.x,
      height: size.y*3,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0, left: 0,
            child: Image.asset(image,
              fit: BoxFit.fill,
              width: size.x,
              height: size.y * 3,
            )
          ),
        ] + counterWidgets
      )
    );
  }
}
