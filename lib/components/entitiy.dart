import 'dart:math';

import 'package:flutter/material.dart';

abstract class Entity {
  Widget render(BuildContext c, Point size);
}