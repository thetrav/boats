

class Turn {
  final int turnNumber;
  final String shipId;
  final plan = Plan();
  Result result;
  Turn({this.turnNumber, this.shipId});
}

class Plan {
  //movement can be:
  //1-9 foreward n hexes
  //p/s turn port or starboard
  List<String> movement = [];


}

class Result {

}