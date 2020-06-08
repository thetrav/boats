import 'package:boats/game/wind.dart';

import 'sail_state.dart';
import 'package:boats/csv.dart' as csv;


class MovementDeterminationTable {
  static MovementDeterminationTable instance;
  final Map<String, Map<WindFacing, int>> tableMap =
    Map<String,Map<WindFacing, int>>();

  Map<WindFacing, int> split(String data) {
    final row = data.split("-").map((s) => int.parse(s)).toList();
    return {
      LUFFING: row[0],
      CLOSE_HAULED: row[1],
      BROAD_REACHING: row[2],
      RUNNING: row[3]
    };
  }

  MovementDeterminationTable(String table) {
    csv.read(table).forEach((row) {
      String key = [
        row["Movement Type"],
        row["Rigging Sections Left"],
        row["Sail State"],
      ].join("-");
      tableMap["$key-0"] = split(row["0-Calm"]);
      tableMap["$key-1"] = split(row["1-V.Light"]);
      tableMap["$key-2"] = split(row["2-Light"]);
      tableMap["$key-3"] = split(row["3-Moderate"]);
      tableMap["$key-4"] = split(row["4-Heavy"]);
      tableMap["$key-5"] = split(row["5-Tempest"]);
    });
  }

  static int movementAllowance(String movementType,
    int riggingSections,
    Sail sailState,
    Wind wind,
    WindFacing facing
  ) {
    if(sailState == DOWN) {
      return 0;
    }
    final key = [
      movementType,
      "$riggingSections",
      sailState.name,
      wind.strength
    ].join("-");
    return instance.tableMap[key][facing];
  }
}