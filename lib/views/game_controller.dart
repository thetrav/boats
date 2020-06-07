

import 'dart:math';

import 'package:boats/views/turn_plan_panel.dart';
import 'package:flutter/material.dart';

import '../components/entitiy.dart';
import '../components/ship_entity.dart';
import '../components/constrained_gesture_panel.dart';
import '../game/game.dart';
import '../game/ship.dart';
import '../hex/scrollable_hex.dart';
import 'game_controls.dart';

class GameController extends StatefulWidget {
  final Game game;
  final int hexSize;
  GameController(this.game, this.hexSize);

  @override
  State<StatefulWidget> createState() => _GameControllerState();

}

class _GameControllerState extends State<GameController> {
  Game game;
  int get hexSize => widget.hexSize;

  @override
  void initState() {
    super.initState();

    this.game = widget.game;
  }

  @override
  void didUpdateWidget(GameController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.game != oldWidget.game) {
      setState(() => game = widget.game);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entities = Map<Point, Entity>();
    Point pointFor(Ship ship) => Point(ship.position.q, ship.position.r);
    game.ships.forEach((s)=> entities[pointFor(s)] = ShipEntity(s));

    return Column(
      children: [
        Expanded(
          child: ConstrainedGesturePanel(
            builder: (context, matrix, width, height) => ScrollableHexGrid(
              hexSize: hexSize,
              entities: entities,
              overlays: [
                Positioned(
                  left: 10,
                  top: 10,
                  child: TurnPlanPanel(game))
              ],
              xForm: matrix,
              containerWidth: width,
              containerHeight: height
            )
          ),
        ),
        GameControls(game, (g) => setState(() => game = g))
      ]
    );
  }
}

