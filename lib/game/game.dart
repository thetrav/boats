import 'package:boats/game/ship.dart';

import 'player.dart';
import 'turn.dart';

class Game {
  int turnCount = 1;

  List<Player> players;
  List<Ship> ships;

  Game({
    this.ships,
    this.players
  });

  void simulate() {
    turnCount++;
    movement();
    ships.forEach((s) =>
      s.turns.insert(0, Turn(
        turnNumber: turnCount,
        shipId: s.shipId
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