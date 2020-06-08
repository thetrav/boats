import 'package:boats/game/turn.dart';
import 'package:flutter/material.dart';

class TurnPlanPanel extends StatelessWidget {
  final Turn turn;
  TurnPlanPanel(this.turn);

  Widget text(String s) => Text(s);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      "${turn.ship.shipId} turn: ${turn.turnNumber}",
      "Movement Allowance: ${turn.movementAllowance()}"
    ].map(text).toList() +
      turn.plan.movement.map(
          (s)=> Text(s)
      ).toList()
  );

}