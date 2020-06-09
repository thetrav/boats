

import 'package:boats/game/sail_state.dart';
import 'package:boats/game/ship.dart';
import 'package:boats/game/turn.dart';

import 'game.dart';
import 'tables.dart';

class TurnCalculations {
  final Game game;
  final Ship ship;
  Turn get turn => ship.currentTurn;

  const TurnCalculations({this.game, this.ship});

  int moveAllowance() =>
    MovementDeterminationTable.movementAllowance(
      ship.movementType,
      ship.riggingSections,
      ship.sail,
      game.wind,
      game.wind.windFacing(ship.heading));

  bool canChangeSailTo(Sail target) {
    final plan = turn.plan.sailChange;
    final previous = ship.previousTurn;
    final previousPlan = previous?.plan?.sailChange;
    //cannot change to the state you area already in
    if(ship.sail == target) return false;
    //we are locked into a plan to raise plain sails
    if(plan == PLAIN && previousPlan == PLAIN) return false;
    //we are locked into a plan to lower plain sails
    if(ship.sail == PLAIN && previousPlan == MEDIUM) return false;
    //allow one degree of change
    return target == ship.sail.previous || target == ship.sail.next;
  }
}