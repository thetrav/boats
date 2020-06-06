import 'package:boats/hex/scrollable_hex.dart';
import 'package:flutter/material.dart';

import 'constrained_gesture_panel.dart';

const int HEX_SIZE = 25;

void main() => runApp(Application());

Widget MAP(int q, int r, int s) => Container(color: Colors.green);

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
