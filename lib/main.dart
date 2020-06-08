import 'package:boats/game/game.dart';
import 'package:boats/game/sail_state.dart';
import 'package:boats/game/tables.dart';
import 'package:flutter/material.dart';

import 'game/wind.dart';
import 'views/game_controller.dart';
import 'game/player.dart';
import 'game/ship.dart';
import 'hex/hex_coords.dart';
import 'game/headings.dart';

const int HEX_SIZE = 50;

void main() {
  final List<Player> players = [Player("Travis"), Player("Phil")];
  runApp(Application(Game(
    wind: Wind(N, 3),
    players: players,
    player: players.first,
    ships: [
      Ship(
        playerName: players[0].name,
        shipId: "Adamant",
        shipClass: "Class 1",
        position: Hex(0,0),
        heading: N,
        sail: PLAIN,
        movementType: "L-F"
      ),
      Ship(
        playerName: players[0].name,
        shipId: "Defiant",
        shipClass: "Class 2",
        position: Hex(0,-5),
        heading: N,
        sail: PLAIN,
        movementType: "L-F"
      ),
      Ship(
        playerName: players[1].name,
        shipId: "Dauntless",
        shipClass: "Class 3",
        position: Hex(3,-13),
        heading: S,
        sail: PLAIN,
        movementType: "L-F"
      ),
      Ship(
        playerName: players[1].name,
        shipId: "Providence",
        shipClass: "Class 4",
        position: Hex(3,-16),
        heading: S,
        sail: PLAIN,
        movementType: "L-F"
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
      body: LoadAssets((c)=> GameController(game, HEX_SIZE))
    )
  );
}

class LoadAssets extends StatelessWidget {
  final Widget Function(BuildContext) builder;

  LoadAssets(this.builder);

  Future load(BuildContext c) {
    return DefaultAssetBundle.of(c)
      .loadString("assets/tables/movement_determination.csv").then((s)=>
        MovementDeterminationTable.instance = MovementDeterminationTable(s)
      ).catchError((e, StackTrace s) { print("$s"); throw e;});
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: load(context),
    builder: (context, snapshot) {
      if(snapshot.hasError) {
        return Center(child: Text("Error ${snapshot.error}"));
      }
      if(snapshot.hasData) {
        return builder(context);
      }
      return Center(child: Column(children: [
        CircularProgressIndicator(),
        Text("Loading")
      ]));
    }
  );
}


