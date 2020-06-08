import 'package:boats/game/ship.dart';

import 'player.dart';
import 'turn.dart';
import 'wind.dart';

class Game {
  int turnCount = 1;

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
      ship: s,
      wind: wind,
      turnNumber: turnCount
    )));
  }

  Turn currentTurn(String shipId) => ships.firstWhere((s)=> s.shipId == shipId).turns.first;

  void simulate() {
    turnCount++;
    movement();
    ships.forEach((s) =>
      s.turns.insert(0, Turn(
        turnNumber: turnCount,
        ship: s,
        wind: wind
      ))
    );
  }

  void movement() {
    ships.forEach((s) => {
      s.turns.first.plan.movement.forEach((action) {
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
}