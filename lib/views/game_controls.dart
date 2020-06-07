
import '../game/game.dart';
import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final Game game;
  final Function(Game) updateState;
  GameControls(this.game, this.updateState);

  void planAction(String action) {
    game.ships.first.turns.first.plan.movement.add(action);
    updateState(game);
  }

  void undoPlan() {
    final moves = game.ships.first.turns.first.plan.movement;
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