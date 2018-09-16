import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/css.dart';
import 'package:abstract_theme/src/util/fonts.dart';
import 'package:abstract_theme/src/util/colors.dart';
import 'package:abstract_theme/src/util/borders.dart';

export 'package:abstract_theme/src/util/css.dart';
export 'package:abstract_theme/src/util/fonts.dart';
export 'package:abstract_theme/src/util/colors.dart';
export 'package:abstract_theme/src/util/borders.dart';

/// Combines a [ColorPair], [Border], [Font], and [BoxSpacing].
class Element extends CssEntity {
  const Element({
    @required this.color,
    @required this.font,
    this.border: const Border(),
    this.margin: const BoxSpacing(),
    this.padding: const BoxSpacing(),
  });

  final Color color;
  final Font font;
  final Border border;
  final BoxSpacing margin;
  final BoxSpacing padding;

  @override
  Map<String, String> get cssValues => {
        'background-color': color.toString(),
        'margin': margin.toString(),
        'padding': padding.toString()
      }
        ..addAll(font.cssValues)
        ..addAll(border.cssValues);
}

/// Such as margins or padding.
class BoxSpacing {
  const BoxSpacing([double value = 0.0])
      : top = value,
        right = value,
        bottom = value,
        left = value;
  const BoxSpacing.symmetric({double horizontal: 0.0, double vertical: 0.0})
      : top = vertical,
        right = horizontal,
        bottom = vertical,
        left = horizontal;
  const BoxSpacing.only(
      {this.top: 0.0, this.right: 0.0, this.bottom: 0.0, this.left: 0.0});
  final double top;
  final double right;
  final double bottom;
  final double left;

  /// CSS value
  @override
  String toString() => '${top}px ${right}px ${bottom}px ${left}px';
}
