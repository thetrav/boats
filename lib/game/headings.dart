
import 'dart:math';

import 'package:boats/hex/hex_coords.dart';

const N  = Heading(0, "N",  Hex(0,-1));
const NE = Heading(1, "NE", Hex(1,-1));
const SE = Heading(2, "SE", Hex(1,0));
const S  = Heading(3, "S",  Hex(0,1));
const SW = Heading(4, "SW", Hex(-1,1));
const NW = Heading(5, "NW", Hex(-1,0));

const HEADINGS = [
  N, NE, SE, S, SW, NW
];

class Heading {
  final int index;
  final String label;
  final Hex direction;
  const Heading(this.index, this.label, this.direction);

  static Heading from(Point d) =>
    HEADINGS.firstWhere((h) => h.direction == d);

  Heading get port => index == 0 ?
    HEADINGS.last :
    HEADINGS[index-1];

  Heading get starboard => index == HEADINGS.length-1 ?
    HEADINGS.first :
    HEADINGS[index+1];
}