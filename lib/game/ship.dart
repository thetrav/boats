import 'package:boats/hex/hex_coords.dart';

import 'turn.dart';

class Ship {
  String shipId;
  String shipClass;
  String playerName;
  List<Turn> turns;
  Hex position;
  int heading;

  Ship({
    this.shipId,
    this.playerName,
    this.shipClass,
    this.position,
    this.heading,
    int turnCount}) {
    turns = [Turn(
      turnNumber: turnCount, shipId:shipId
    )];
  }

  void turnPort() {
    heading = heading == 0 ? 5 : heading - 1;
  }

  void turnStarboard() {
    heading = heading == 5 ? 0 : heading + 1;
  }

  void advance(int count) {
    final change = Hex.directions[heading] * count;
    position = position + change;
  }
}