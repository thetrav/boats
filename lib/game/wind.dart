import 'headings.dart';

class Wind {
  //0 to 5
  final int strength;
  final Heading direction;

  const Wind(this.direction, this.strength);

  WindFacing windFacing(Heading heading) {
    if(direction == heading) {
      return RUNNING;
    }
    if(direction.direction == heading.direction * -1) {
      return LUFFING;
    }
    if(direction == heading.port || direction == heading.starboard) {
      return BROAD_REACHING;
    }
    return CLOSE_HAULED;
  }
}

const RUNNING = WindFacing("R", "Running");
const LUFFING = WindFacing("L", "Luffing");
const BROAD_REACHING = WindFacing("B", "Broad-Reaching");
const CLOSE_HAULED = WindFacing("C", "Close-Hauled");

class WindFacing {
  final String id;
  final String longName;

  const WindFacing(this.id, this.longName);
}
