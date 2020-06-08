import 'package:boats/game/wind.dart';

import 'ship.dart';

class Turn {
  final int turnNumber;
  final Ship ship;
  final Wind wind;
  final plan = Plan();
  Result result;
  Turn({
    this.turnNumber,
    this.ship,
    this.wind
  });

  int movementAllowance() => ship.moveAllowance(wind);
}

class Plan {
  //movement can be:
  //1-9 foreward n hexes
  //p/s turn port or starboard
  List<String> movement = [];
}

class Result {

}