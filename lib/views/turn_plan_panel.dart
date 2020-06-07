import 'package:boats/game/game.dart';
import 'package:flutter/material.dart';

class TurnPlanPanel extends StatelessWidget {
  Game game;
  TurnPlanPanel(this.game);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white70,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [Text("Planned Turn ${game.turnCount}")] +
          game.ships.first.turns.first.plan.movement.map(
              (s)=> Text(s)
          ).toList()
      )
    )
  );

}