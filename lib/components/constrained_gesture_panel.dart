import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

typedef MathF<T extends num> = T Function(T, T);
typedef VFn = vec.Vector4 Function(double x, double y, double z, double w);

const double MIN_SCALE = 0.6;
const double MAX_SCALE = 10;

double _minMax(num _min, num _max, num actual) {
  if (_min == null && _max == null) {
    return actual.toDouble();
  }

  if (_min == null) {
    return min(_max.toDouble(), actual.toDouble());
  }

  if (_max == null) {
    return max(_min.toDouble(), actual.toDouble());
  }

  return min(_max.toDouble(), max(_min.toDouble(), actual.toDouble()));
}

Map<int, VFn> _colMap = {
  0: (x, y, z, w) {
    x = _minMax(MIN_SCALE, MAX_SCALE, x);
    return vec.Vector4(x, y, z, w);
  },
  1: (x, y, z, w) {
    y = _minMax(MIN_SCALE, MAX_SCALE, y);
    return vec.Vector4(x, y, z, w);
  },
  2: (x, y, z, w) {
    z = _minMax(MIN_SCALE, MAX_SCALE, z);
    return vec.Vector4(x, y, z, w);
  },
};

void noop(Matrix4 m, Point size) {}

class ConstrainedGesturePanel extends StatefulWidget {

  final Function(Matrix4, Point) onUpdate;
  final Widget Function(BuildContext, Matrix4, double, double) builder;

  ConstrainedGesturePanel({
    this.onUpdate = noop,
    @required this.builder
  });

  @override
  State<ConstrainedGesturePanel> createState() => _ConstrainedGesturePanelState();
}

class _ConstrainedGesturePanelState
  extends State<ConstrainedGesturePanel>
  with AfterLayoutMixin<ConstrainedGesturePanel> {

  bool _isAfterFirstLayout = false;
  Matrix4 matrix = Matrix4.identity();

  final GlobalKey _containerKey = GlobalKey();

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() => _isAfterFirstLayout = true);
  }

  double get containerHeight {
    RenderBox containerBox = _containerKey.currentContext.findRenderObject();
    return containerBox.size.height;
  }

  double get containerWidth {
    RenderBox containerBox = _containerKey.currentContext.findRenderObject();
    return containerBox.size.width;
  }

  @override
  void initState() {
    super.initState();

    _isAfterFirstLayout = false;
  }

  Matrix4 constrain(Matrix4 m) {
    Matrix4 finalM = Matrix4.copy(m);

    for (var col in _colMap.keys) {
      var oldCol = m.getColumn(col);
      var colD = _colMap[col];
      if (colD != null) {
        finalM.setColumn(col, colD(oldCol.x, oldCol.y, oldCol.z, oldCol.w));
      }
    }
    return finalM;
  }

  @override
  Widget build(BuildContext c) =>
    Container(
      key: _containerKey,
      color: Colors.yellow,
      child: _isAfterFirstLayout ?
      MatrixGestureDetector(
        shouldRotate: false,
        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          var finalM = constrain(m);
          setState(() {
            matrix = finalM;
          });
          widget.onUpdate(finalM, Point(containerWidth, containerHeight));
        },
        child: Container(
          color: Colors.blue,
          child: widget.builder(context, matrix, containerWidth, containerHeight)
        )): Center(child: Column(children:[
          CircularProgressIndicator(), Text("Loading")
        ]))
      );
}