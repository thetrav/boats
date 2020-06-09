

import 'dart:math';

import 'package:boats/game/turn.dart';
import 'package:boats/game/turn_calculations.dart';
import 'package:boats/hex/hex_coords.dart';
import 'package:boats/views/ship_panel.dart';
import 'package:boats/views/turn_plan_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;
import 'package:vector_math/vector_math_64.dart';

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
  Ship currentShip;
  Hex selectedHex;
  int get hexSize => widget.hexSize;
  bool loading;
  Turn get currentTurn => currentShip.currentTurn;
  TurnCalculations turnCalculations;

  int get movementAllowance =>
    turnCalculations.moveAllowance();

  @override
  void initState() {
    super.initState();
    resetState();
  }

  //WARNING: only call inside init or setState!
  void resetState() {
    selectedHex = Hex(0,0);
    this.game = widget.game;
    currentShip = game.ships.firstWhere((s)=> s.playerName == game.player.name);
    turnCalculations = TurnCalculations(
      game: game,
      ship: currentShip
    );
  }

  @override
  void didUpdateWidget(GameController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.game != oldWidget.game) {
      setState(() => resetState());
    }
  }

  void updateSelectedHex( Vector3 translation, Vector3 scale, Point containerSize) {
    final scaledHexSize = hexSize * scale.x;
    final size = Point(scaledHexSize, scaledHexSize);
    final layout = HexLayout.orientFlat(size);
    final Point zero = Point(-translation.x,-translation.y);
    final centerHex = Hex.fromPoint(layout, zero);
    if(centerHex != selectedHex.q) {
      setState(()=> selectedHex = centerHex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entities = Map<Point, Entity>();
    Point pointFor(Ship ship) => Point(ship.position.q, ship.position.r);
    Ship targetShip;
    game.ships.forEach((s) {
      entities[pointFor(s)] = ShipEntity(s);
      if(s.position == selectedHex) {
        targetShip = s;
      }
    });

    final overlays = [
      Positioned(left: 10, top: 10, child: OverlayPanel(TurnPlanPanel(currentTurn))
      ),
    ];
    if (targetShip != null) {
      overlays.add(Positioned(
        right: 10,
        top: 10,
        child: OverlayPanel(ShipPanel(
          game,
          targetShip,
          () => setState(() => currentShip = targetShip)
        ))
      ));
    }


    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children:
          [
            "${game.player.name}",
            "Wind: ${game.wind.direction.label}, ${game.wind.strength}",
            "${currentShip.shipId} turn: ${currentTurn.turnNumber}",
            "Movement Allowance: $movementAllowance"
          ].map((s)=> Text(s)).toList()
        ),
        Expanded(
          child: ConstrainedGesturePanel(
            builder: (context, matrix, width, height) => ScrollableHexGrid(
              hexSize: hexSize,
              entities: entities,
              overlays: overlays,
              xForm: matrix,
              containerWidth: width,
              containerHeight: height
            ),
            onUpdate: (xForm, containerSize) {
              Vector3 translation = Vector3.zero();
              Quaternion rotation = Quaternion.identity();
              Vector3 scale = Vector3.zero();

              xForm.decompose(translation, rotation, scale);
              updateSelectedHex(translation, scale, containerSize);
            }
          ),
        ),
        GameControls(
          game: game,
          ship: currentShip,
          turnCalculations: turnCalculations,
          updateState: (g) => setState(() {
            game = g;
            turnCalculations = TurnCalculations(
              game: game,
              ship: currentShip
            );
          })
        )
      ]
    );
  }
}

class OverlayPanel extends StatelessWidget {
  Widget child;
  OverlayPanel(this.child);

  @override
  Widget build(BuildContext context) => Container(
    color: m.Colors.white70,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: child
    )
  );
}