import 'package:boats/hex/hex_coords.dart';

import 'headings.dart';
import 'sail_state.dart';
import 'turn.dart';

class Ship {
  String shipId;
  String shipClass;
  String playerName;
  List<Turn> turns = <Turn>[];
  Hex position;
  Heading heading;
  String movementType;
  Sail sail;

  int riggingDamage = 0;
  int get riggingSections => 4;

  Ship({
    this.shipId,
    this.playerName,
    this.shipClass,
    this.position,
    this.heading,
    this.movementType,
    this.sail});

  Turn get currentTurn => turns.last;
  Turn get previousTurn {
    final index = currentTurn.turnNumber;
    if(index > 0 ) {
      return turns[index - 1];
    }
    return null;
  }

  void turnPort() {
    heading = heading.port;
  }

  void turnStarboard() {
    heading = heading.starboard;
  }

  void advance(int count) {
    final change = heading.direction * count;
    position = position + change;
  }
}