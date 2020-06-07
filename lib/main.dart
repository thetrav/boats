import 'dart:math';

import 'package:boats/game/hex_map.dart';
import 'package:boats/hex/scrollable_hex.dart';
import 'package:flutter/material.dart';

import 'constrained_gesture_panel.dart';

const int HEX_SIZE = 25;
HexMap MAP = HexMap();

void main() {
  MAP.entities[Point(0,0)] = ShipEntity(image: "Class 1 MS");
  runApp(Application());
}

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Boats!',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        headline5: TextStyle(
          color: Colors.blue,
          fontSize: 18.0,
        ),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("Boats!"),
        centerTitle: true,
      ),
      body: Container(
        child: ConstrainedGesturePanel(
          builder: (context, matrix, width, height) => ScrollableHexGrid(
            hexSize: HEX_SIZE,
            map: MAP,
            xForm: matrix,
            containerWidth: width,
            containerHeight: height
          )
        )
      )
    )
  );
}
