// Import the test package and Counter class
import 'package:boats/hex/transformation.dart';
import 'package:test/test.dart';
import 'package:vector_math/vector_math_64.dart';


void main() {

  test('Scale correctly interpreted', () {
    final scale = 2.5;
    final xForm = Matrix4.identity()..scale(scale, scale, scale);

    final result = calculateScale(xForm);

    expect(result, scale);
  });

  test('Translation correctly interpreted', () {
    final x = 5.0;
    final y = 3.0;
    final xForm = Matrix4.identity()..translate(x, y);

    final calculation = calculateTranslation(1, xForm);

    expect(calculation.x, x);
    expect(calculation.y, y);
  });


  test('scale and transform work together', () {
    final scale = 2.5;
    final x = 5.0;
    final y = 3.0;
    final xForm = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale, scale, scale);

    final result = TransformedValues(xForm);
    expect(result.scale, scale);
    expect(result.x, x);
    expect(result.y, y);
  });

  test('order is relevant, translations after scale are magnified', () {
    final scale = 2.5;
    final x = 5.0;
    final y = 3.0;
    final xForm = Matrix4.identity()
      ..scale(scale, scale, scale)
      ..translate(x, y);

    final result = TransformedValues(xForm);
    expect(result.scale, scale);
    expect(result.x, x*scale);
    expect(result.y, y*scale);
  });

  test('negative values work', () {
    final scale = -2.5;
    final x = -0.01;
    final y = -0.5;
    final xForm = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale, scale, scale);

    final result = TransformedValues(xForm);
    expect(result.scale, scale);
    expect(result.x, x);
    expect(result.y, y);
  });
}
