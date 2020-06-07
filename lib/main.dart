import 'package:boats/game/game.dart';
import 'package:flutter/material.dart';

import 'views/game_controller.dart';
import 'game/player.dart';
import 'game/ship.dart';
import 'hex/hex_coords.dart';
import 'headings.dart';

const int HEX_SIZE = 50;

void main() {
  runApp(Application(Game(
    players: [Player("Travis")],
    ships: [
      Ship(
        playerName: "Travis",
        shipId: "Adamant",
        shipClass: "Class 1",
        position: Hex(0,0),
        heading: N,
        turnCount: 01
      )
    ]
  )));
}

class Application extends StatelessWidget {
  final Game game;

  Application(this.game);

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
      body: GameController(game, HEX_SIZE)
    )
  );
}
