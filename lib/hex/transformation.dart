import 'package:vector_math/vector_math_64.dart';

Vector2 calculateTranslation(double scale, Matrix4 matrix) {
  final translated = Vector3(0,0,0)
    ..applyMatrix4(matrix);
  return Vector2(translated.x, translated.y);
}

//assumes even scaling
double calculateScale(Matrix4 matrix) {
  final x1 = Vector3(0,0,0)
    ..applyMatrix4(matrix);
  final x2 = Vector3(1,0,0)
    ..applyMatrix4(matrix);
  return x2.x - x1.x;
}

class TransformedValues {
  Matrix4 xForm;
  Vector2 translation;
  double get x => translation.x;
  double get y => translation.y;
  double scale;

  TransformedValues(this.xForm) {
    this.scale = calculateScale(xForm);
    this.translation = calculateTranslation(scale, xForm);
  }
}