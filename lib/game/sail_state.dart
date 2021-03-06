
const DOWN = Sail(0,"furl/d");
const FIGHTING = Sail(1,"FS");
const MEDIUM = Sail(2, "MS");
const PLAIN = Sail(3, "PS");

const SAIL_STATES = [
  DOWN, FIGHTING, MEDIUM, PLAIN
];

class Sail {
  final int index;
  final String name;
  const Sail(this.index, this.name);

  Sail get previous => index == 0 ?
    null :
    SAIL_STATES[index-1];

  Sail get next => index == SAIL_STATES.length-1 ?
    null :
    SAIL_STATES[index+1];

  @override
  String toString() => "SailState[$name]";
}