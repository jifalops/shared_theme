import 'package:abstract_theme/src/util/css.dart';
import 'package:abstract_theme/src/util/color.dart';

class Border extends CssEntity {
  const Border(
      {BorderSide sides: const BorderSide(),
      BorderRadius radii: const BorderRadius()})
      : top = sides,
        right = sides,
        bottom = sides,
        left = sides,
        topLeft = radii,
        topRight = radii,
        bottomRight = radii,
        bottomLeft = radii;
  const Border.complex({
    this.top: const BorderSide(),
    this.right: const BorderSide(),
    this.bottom: const BorderSide(),
    this.left: const BorderSide(),
    this.topLeft: const BorderRadius(),
    this.topRight: const BorderRadius(),
    this.bottomRight: const BorderRadius(),
    this.bottomLeft: const BorderRadius(),
  });
  final BorderSide top, right, bottom, left;
  final BorderRadius topLeft, topRight, bottomRight, bottomLeft;

  @override
  Map<String, String> get cssValues => {
        'border-top': top.toString(),
        'border-right': right.toString(),
        'border-bottom': bottom.toString(),
        'border-left': left.toString(),
        'border-radius':
            '${topLeft.first}px ${topRight.first}px ${bottomLeft.first}px ${bottomRight.first}px / ${topLeft.second}px ${topRight.second}px ${bottomLeft.second}px ${bottomRight.second}px',
      };
}

class BorderSide {
  const BorderSide({this.width: 0.0, this.style: BorderStyle.none, this.color});
  final double width;
  final BorderStyle style;
  final Color color;

  /// CSS value
  @override
  String toString() => '${width}px $style ${color?.toString() ?? ''}';

  @override
  bool operator ==(o) =>
      o is BorderSide &&
      width == o.width &&
      style == o.style &&
      color == o.color;
  @override
  int get hashCode => toString().hashCode;
}

class BorderRadius {
  const BorderRadius([double radius = 0.0])
      : first = radius,
        second = radius;
  const BorderRadius.asymmetric(this.first, this.second);
  final double first;
  final double second;
}

class BorderStyle {
  const BorderStyle._(this._name);
  final String _name;

  static const BorderStyle none = BorderStyle._('none');
  static const BorderStyle solid = BorderStyle._('solid');

  /// CSS value
  @override
  String toString() => _name;
}
