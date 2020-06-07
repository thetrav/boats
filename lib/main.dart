import 'package:boats/game/game.dart';
import 'package:flutter/material.dart';

import 'views/game_controller.dart';
import 'game/player.dart';
import 'game/ship.dart';
import 'hex/hex_coords.dart';
import 'headings.dart';

const int HEX_SIZE = 50;

void main() {
  final List<Player> players = [Player("Travis"), Player("Phil")];
  runApp(Application(Game(
    players: players,
    player: players.first,
    ships: [
      Ship(
        playerName: players[0].name,
        shipId: "Adamant",
        shipClass: "Class 1",
        position: Hex(0,0),
        heading: N,
        turnCount: 01
      ),
      Ship(
        playerName: players[0].name,
        shipId: "Defiant",
        shipClass: "Class 2",
        position: Hex(0,-5),
        heading: N,
        turnCount: 01
      ),
      Ship(
        playerName: players[1].name,
        shipId: "Dauntless",
        shipClass: "Class 3",
        position: Hex(3,-13),
        heading: S,
        turnCount: 01
      ),
      Ship(
        playerName: players[1].name,
        shipId: "Providence",
        shipClass: "Class 4",
        position: Hex(3,-16),
        heading: S,
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
