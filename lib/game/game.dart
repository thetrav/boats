import 'package:boats/game/ship.dart';

import 'player.dart';
import 'sail_state.dart';
import 'turn.dart';
import 'wind.dart';

class Game {
  int turnCount = 0;

  Player player;
  List<Player> players;
  List<Ship> ships;
  Wind wind;

  Game({
    this.ships,
    this.players,
    this.player,
    this.wind
  }) {
    this.ships.forEach((s)=> s.turns.add(Turn(
      turnNumber: turnCount,
      shipId: s.shipId
    )));
  }

  Turn currentTurn(String shipId) =>
    ships.firstWhere((s)=> s.shipId == shipId).currentTurn;

  void simulate() {
    turnCount++;
    movement();
    ships
      .where((s) => s.currentTurn.plan.sailChange != null )
      .forEach(sailChanges);
    prepareNextTurn();
  }

  void movement() {
    ships.forEach((s) => {
      s.currentTurn.plan.movement.forEach((action) {
        if(action == "P") {
          s.turnPort();
        } else if(action == "S") {
          s.turnStarboard();
        } else {
          s.advance(int.tryParse(action) ?? 0);
        }
      })
    });
  }

  void sailChanges(Ship s) {
    final plan = s.currentTurn.plan.sailChange;
    final previousPlan = s.previousTurn?.plan?.sailChange;

    //takes two turns to raise plain sails
    if(plan == PLAIN && previousPlan != PLAIN) {
      return;
    }
    //takes two turns to lower plain sails
    if (s.sail == PLAIN &&
      plan == MEDIUM &&
      previousPlan != MEDIUM){
      return;
    }
    s.sail = plan;
  }

  void prepareNextTurn() {
    ships.forEach((s) {
      s.turns.add(Turn(
        turnNumber: turnCount,
        shipId: s.shipId,
      ));
      final sailChange = s.previousTurn?.plan?.sailChange;
      if(sailChange != s.sail) {
        s.currentTurn.plan.sailChange = sailChange;
      }
    });
  }
}