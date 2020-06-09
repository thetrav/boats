import 'package:boats/game/sail_state.dart';
import 'package:boats/game/ship.dart';
import 'package:boats/game/turn.dart';
import 'package:boats/game/turn_calculations.dart';

import '../game/game.dart';
import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final Game game;
  final Ship ship;
  final Function(Game) updateState;
  final TurnCalculations turnCalculations;

  GameControls({
    this.game,
    this.ship,
    this.updateState,
    this.turnCalculations
  });

  Turn get currentTurn => ship.currentTurn;

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
        SailButtons(
          currentTurn: currentTurn,
          turnCalculations: turnCalculations,
          sail: ship.sail,
          update: update,
        ),
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

  update(Function f) {
    f();
    updateState(game);
  }
}

class SailButtons extends StatelessWidget {
  final TurnCalculations turnCalculations;
  final Sail sail;
  final Turn currentTurn;
  final Function(Function) update;

  SailButtons({
    this.turnCalculations,
    this.currentTurn,
    this.sail,
    this.update
  });

  Widget button(String t, Sail target) {
    final plan = currentTurn.plan;
    if(turnCalculations.canChangeSailTo(target)) {
      if(plan.sailChange == target) {
        return RaisedButton.icon(
          icon: Icon(Icons.done),
          label: Text(t),
          onPressed: () => update((){
            plan.sailChange = null;
          })
        );
      } else {
        return RaisedButton(
          child: Text(t),
          onPressed: () => update((){
            plan.sailChange = target;
          }),
        );
      }
    }
    if(sail == target) {
      return FlatButton.icon(
        icon: Icon(Icons.done),
        label: Text(t),
        onPressed: null
      );
    }
    return FlatButton(child: Text(t), onPressed: null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        button("Furl/D", DOWN),
        button("FS", FIGHTING),
        button("MS", MEDIUM),
        button("PS", PLAIN)
      ]
    );
  }
}
