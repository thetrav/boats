
import 'package:boats/game/game.dart';
import 'package:boats/game/ship.dart';
import 'package:flutter/material.dart';

class ShipPanel extends StatelessWidget {
  final Game game;
  final Ship ship;
  final Function select;

  ShipPanel(this.game, this.ship, this.select);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text("Ship: ${ship.shipId}"),
      Text("Owned by: ${ship.playerName}")
    ];
    if(ship.playerName == game.player.name) {
      children.add(RaisedButton(child: Text("Select Ship"), onPressed: select));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
    );
  }
}