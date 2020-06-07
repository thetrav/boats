import 'package:boats/game/ship.dart';
import 'package:boats/game/turn.dart';

import '../game/game.dart';
import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final Game game;
  final Ship ship;
  final String currentShipId;
  final Function(Game) updateState;
  GameControls({
    this.game,
    this.ship,
    this.currentShipId,
    this.updateState
  });

  Turn get currentTurn => ship.turns.first;

  void planAction(String action) {
    currentTurn.plan.movement.add(action);
    updateState(game);
  }

  void undoPlan() {
    final moves = currentTurn.plan.movement;
    if(moves.isNotEmpty) {
      moves.removeLast();
      updateState(game);
    }
  }

  void progressTurn() {
    game.simulate();
    updateState(game);
  }


  Widget iconButton(IconData icon, void Function() action) =>
    RaisedButton.icon(
      label: Text(""),
      icon: Icon(icon),
      onPressed: action
    );

  Widget actionButton(IconData icon, String action) =>
    iconButton(icon, () => planAction(action));

  @override
  Widget build(BuildContext c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            actionButton(Icons.rotate_left,"P"),
            actionButton(Icons.arrow_upward,"1"),
            actionButton(Icons.rotate_right, "S"),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconButton(Icons.cancel, undoPlan),
            iconButton(Icons.done, progressTurn),
          ]
        )
      ]
    );
  }


}