import 'dart:math';

import 'package:flutter/material.dart';

abstract class Entity {
  Widget render(BuildContext c, Point size);
}

class ErrorBox extends StatelessWidget {
  final String text;

  const ErrorBox(this.text);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.red,
    child: Text(text, style:
      Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)
    )
  );
}

class ShipEntity extends Entity {
  final String image;
  ShipEntity({this.image});

  @override
  Widget render(BuildContext c, Point size) =>
    Container(
      transform: Matrix4.translationValues(-size.x/2, -size.y/2, 1),
      alignment: Alignment.center,
      child: Image.asset("assets/images/$image.png",
        fit: BoxFit.fill,
        width: size.x,
        height: size.y*3,
      )
    );
}

class HexMap {
  final entities = Map<Point, Entity>();
}