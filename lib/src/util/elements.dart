import 'package:meta/meta.dart';
import 'package:shared_theme/src/util/css.dart';
import 'package:shared_theme/src/util/fonts.dart';
import 'package:shared_theme/src/util/colors.dart';
import 'package:shared_theme/src/util/borders.dart';

export 'package:shared_theme/src/util/borders.dart';

/// Combines color, font, margin, padding, border, shadow, and text align.
class Element extends CssEntity {
  const Element({
    @required this.color,
    @required this.font,
    this.border: const Border(),
    this.margin: const BoxSpacing(),
    this.padding: const BoxSpacing(),
    this.shadow: ShadowElevation.none,
    this.align: TextAlign.start,
  })  : assert(color != null),
        assert(font != null),
        assert(border != null),
        assert(margin != null),
        assert(padding != null),
        assert(shadow != null),
        assert(align != null);

  final Color color;
  final Font font;
  final Border border;
  final BoxSpacing margin;
  final BoxSpacing padding;
  final ShadowElevation shadow;
  final TextAlign align;

  @override
  Map<String, String> get cssValues => {
        'background-color': color.toString(),
        'margin': margin.toString(),
        'padding': padding.toString(),
        'text-align': align.toString(),
        'box-shadow': shadow.toString(),
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

class TextAlign {
  const TextAlign._(this._name);
  final String _name;

  static const left = TextAlign._('left');
  static const right = TextAlign._('right');
  static const center = TextAlign._('center');
  static const justify = TextAlign._('justify');
  static const start = TextAlign._('start');
  static const end = TextAlign._('end');

  @override
  String toString() => _name;
}

/// Valid material elevations in dp.
class ShadowElevation {
  const ShadowElevation._(this._boxShadow);
  final String _boxShadow;

  static const none = ShadowElevation._('none');

  static const dp2 =
      ShadowElevation._(''' 0 2px 2px 0 rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 3px 1px -2px rgba(0, 0, 0, $_ambientShadowOpacity),
        0 1px 5px 0 rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp3 =
      ShadowElevation._(''' 0 3px 4px 0 rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 3px 3px -2px rgba(0, 0, 0, $_ambientShadowOpacity),
        0 1px 8px 0 rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp4 =
      ShadowElevation._(''' 0 4px 5px 0 rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 1px 10px 0 rgba(0, 0, 0, $_ambientShadowOpacity),
        0 2px 4px -1px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp6 =
      ShadowElevation._(''' 0 6px 10px 0 rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 1px 18px 0 rgba(0, 0, 0, $_ambientShadowOpacity),
        0 3px 5px -1px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp8 =
      ShadowElevation._(''' 0 8px 10px 1px rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 3px 14px 2px rgba(0, 0, 0, $_ambientShadowOpacity),
        0 5px 5px -3px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp12 =
      ShadowElevation._(''' 0 12px 17px 2px rgba(0, 0, 0, $_keyPenumbraOpacity),
        0 5px 22px 4px rgba(0, 0, 0, $_ambientShadowOpacity),
        0 7px 8px -4px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp16 =
      ShadowElevation._(''' 0 16px 24px 2px rgba(0, 0, 0, $_keyPenumbraOpacity),
        0  6px 30px 5px rgba(0, 0, 0, $_ambientShadowOpacity),
        0  8px 10px -5px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  static const dp24 =
      ShadowElevation._(''' 0 24px 38px 3px rgba(0, 0, 0, $_keyPenumbraOpacity),
        0  9px 46px 8px rgba(0, 0, 0, $_ambientShadowOpacity),
        0  11px 15px -7px rgba(0, 0, 0, $_keyUmbraOpacity)''');

  /// CSS value
  @override
  String toString() => _boxShadow;
}

const _keyUmbraOpacity = 0.2;
const _keyPenumbraOpacity = 0.14;
const _ambientShadowOpacity = 0.12;
const _shadowTransition = 'box-shadow .28s cubic-bezier(.4, 0, .2, 1)';
