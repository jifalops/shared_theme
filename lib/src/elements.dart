import 'package:shared_theme/src/css.dart';
import 'package:shared_theme/src/fonts.dart';
import 'package:shared_theme/src/colors.dart';

/// Used to scale certain sizes between CSS pixels and Logical pixels.
/// Currently only used for [BoxSpacing] (margins and padding).
const _dpToPx = 96 / 160;

/// An abstract container with commonly used properties such as color, font,
/// margin, padding, border, shadow, text align, and size constraints.
///
/// Leave a property `null` to inherit from the underlying platform.
class Element extends CssEntity {
  const Element({
    this.color,
    this.font,
    this.border,
    this.margin,
    this.padding,
    this.shadow,
    this.align,
    this.size,
  });

  final Color color;
  final Font font;
  final Border border;
  final BoxSpacing margin;
  final BoxSpacing padding;
  final ShadowElevation shadow;
  final TextAlign align;
  final SizeLimits size;

  Element copyWith({
    Color color,
    Font font,
    Border border,
    BoxSpacing margin,
    BoxSpacing padding,
    ShadowElevation shadow,
    TextAlign align,
    SizeLimits sizeLimits,
  }) =>
      Element(
        color: color ?? this.color,
        font: font ?? this.font,
        border: border ?? this.border,
        margin: margin ?? this.margin,
        padding: padding ?? this.padding,
        shadow: shadow ?? this.shadow,
        align: align ?? this.align,
        size: sizeLimits ?? this.size,
      );

  @override
  Map<String, String> get cssValues {
    final map = <String, String>{};
    if (color != null) map['background-color'] = color.toString();
    if (margin != null) map['margin'] = margin.toString();
    if (padding != null) map['padding'] = padding.toString();
    if (align != null) map['text-align'] = align.toString();
    if (shadow != null) map['box-shadow'] = '($shadow)';
    if (font != null) map.addAll(font.cssValues);
    if (border != null) map.addAll(border.cssValues);
    if (size != null) map.addAll(size.cssValues);
    return map;
  }

  /// An element with the border and padding of Flutter's underline input type.
  static const underlineInput =
      Element(border: Border.underlineInput, padding: BoxSpacing.inputPadding);

  /// An element with the border and padding of Flutter's outline input type.
  static const outlineInput =
      Element(border: Border.outlineInput, padding: BoxSpacing.inputPadding);
}

/// The named elements in a theme.
class ElementSet implements CssEntityContainer {
  const ElementSet({
    this.primaryButton: const Element(),
    this.secondaryButton: const Element(),
    this.tertiaryButton: const Element(),
    this.inputBase: const Element(),
  });
  final Element primaryButton;
  final Element secondaryButton;
  final Element tertiaryButton;
  final Element inputBase;

  ElementSet copyWith({
    Element primaryButton,
    Element secondaryButton,
    Element tertiaryButton,
    Element inputBase,
  }) =>
      ElementSet(
        primaryButton: primaryButton ?? this.primaryButton,
        secondaryButton: secondaryButton ?? this.secondaryButton,
        tertiaryButton: tertiaryButton ?? this.tertiaryButton,
        inputBase: inputBase ?? this.inputBase,
      );

  @override
  String asScssMap() => '''(
    primaryButton: ${primaryButton.asScssMap()},
    secondaryButton: ${secondaryButton.asScssMap()},
    tertiaryButton: ${tertiaryButton.asScssMap()},
    inputBase: ${inputBase.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) => <String>[
        primaryButton.asThemifiedMixin(
            'primary-button', List.from(parentKeys)..add('primaryButton')),
        secondaryButton.asThemifiedMixin(
            'secondary-button', List.from(parentKeys)..add('secondaryButton')),
        tertiaryButton.asThemifiedMixin(
            'tertiary-button', List.from(parentKeys)..add('tertiaryButton')),
        inputBase.asThemifiedMixin(
            'input-base', List.from(parentKeys)..add('inputBase')),
      ];
}

/// Height and width min/max limits. Defaults to unlimited.
class SizeLimits extends CssEntity {
  const SizeLimits(
      {this.minHeight: 0.0,
      this.maxHeight: double.maxFinite,
      this.minWidth: 0.0,
      this.maxWidth: double.maxFinite});
  final double minHeight;
  final double maxHeight;
  final double minWidth;
  final double maxWidth;

  @override
  Map<String, String> get cssValues => {
        'min-height': '${minHeight}px',
        'max-height': '${maxHeight}px',
        'min-width': '${minWidth}px',
        'max-width': '${maxWidth}px',
      };
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

  /// CSS value.
  @override
  String toString() =>
      '${top * _dpToPx}px ${right * _dpToPx}px ${bottom * _dpToPx}px ${left * _dpToPx}px';

  @override
  bool operator ==(o) =>
      o is BoxSpacing &&
      top == o.top &&
      right == o.right &&
      bottom == o.bottom &&
      left == o.left;
  @override
  int get hashCode => toString().hashCode;

  static const zero = BoxSpacing(0.0);

  /// The padding to mimic Flutter's TextField input.
  static const inputPadding =
      BoxSpacing.symmetric(horizontal: 8.0, vertical: 16.0);
}

/// How text should be aligned in a container, e.g. an [Element].
class TextAlign {
  const TextAlign._(this._name);
  final String _name;

  static const left = TextAlign._('left');
  static const right = TextAlign._('right');
  static const center = TextAlign._('center');
  static const justify = TextAlign._('justify');
  static const start = TextAlign._('start');
  static const end = TextAlign._('end');

  /// CSS value.
  @override
  String toString() => _name;
}

/// Valid material elevations in dp.
class ShadowElevation {
  const ShadowElevation._(this._boxShadow, this.elevation);
  final String _boxShadow;
  final double elevation;

  static const none = ShadowElevation._('none', 0.0);

  static const dp2 = ShadowElevation._(
      '0 2px 2px 0 rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 3px 1px -2px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 1px 5px 0 rgba(0, 0, 0, $_keyUmbraOpacity)',
      2.0);

  static const dp3 = ShadowElevation._(
      '0 3px 4px 0 rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 3px 3px -2px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 1px 8px 0 rgba(0, 0, 0, $_keyUmbraOpacity)',
      3.0);

  static const dp4 = ShadowElevation._(
      '0 4px 5px 0 rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 1px 10px 0 rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 2px 4px -1px rgba(0, 0, 0, $_keyUmbraOpacity)',
      4.0);

  static const dp6 = ShadowElevation._(
      '0 6px 10px 0 rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 1px 18px 0 rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 3px 5px -1px rgba(0, 0, 0, $_keyUmbraOpacity)',
      6.0);

  static const dp8 = ShadowElevation._(
      '0 8px 10px 1px rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 3px 14px 2px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 5px 5px -3px rgba(0, 0, 0, $_keyUmbraOpacity)',
      8.0);

  static const dp12 = ShadowElevation._(
      '0 12px 17px 2px rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0 5px 22px 4px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0 7px 8px -4px rgba(0, 0, 0, $_keyUmbraOpacity)',
      12.0);

  static const dp16 = ShadowElevation._(
      '0 16px 24px 2px rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0  6px 30px 5px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0  8px 10px -5px rgba(0, 0, 0, $_keyUmbraOpacity)',
      16.0);

  static const dp24 = ShadowElevation._(
      '0 24px 38px 3px rgba(0, 0, 0, $_keyPenumbraOpacity), '
      '0  9px 46px 8px rgba(0, 0, 0, $_ambientShadowOpacity), '
      '0  11px 15px -7px rgba(0, 0, 0, $_keyUmbraOpacity)',
      24.0);

  /// CSS value
  @override
  String toString() => _boxShadow;
}

const _keyUmbraOpacity = 0.2;
const _keyPenumbraOpacity = 0.14;
const _ambientShadowOpacity = 0.12;
const _shadowTransition = 'box-shadow .28s cubic-bezier(.4, 0, .2, 1)';

/// A border has four [BorderSides] and four corners, each a [BorderRadius].
class Border extends CssEntity {
  const Border({BorderSide sides, BorderRadius radii})
      : top = sides,
        right = sides,
        bottom = sides,
        left = sides,
        topLeft = radii,
        topRight = radii,
        bottomRight = radii,
        bottomLeft = radii;
  const Border.complex({
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.topLeft,
    this.topRight,
    this.bottomRight,
    this.bottomLeft,
  });
  final BorderSide top, right, bottom, left;
  final BorderRadius topLeft, topRight, bottomRight, bottomLeft;

  @override
  Map<String, String> get cssValues {
    final map = <String, String>{};
    if (top != null) map['border-top'] = top.toString();
    if (bottom != null) map['border-bottom'] = bottom.toString();
    if (left != null) map['border-left'] = left.toString();
    if (right != null) map['border-right'] = right.toString();
    if (topLeft != null) map['border-top-left-radius'] = topLeft.toString();
    if (topRight != null) map['border-top-right-radius'] = topRight.toString();
    if (bottomRight != null)
      map['border-bottom-right-radius'] = bottomRight.toString();
    if (bottomLeft != null)
      map['border-bottom-left-radius'] = bottomLeft.toString();
    return map;
  }

  /// True if any corners have a non-zero radius.
  bool get hasRadius =>
      (topLeft != null && topLeft != BorderRadius.zero) ||
      (topRight != null && topRight != BorderRadius.zero) ||
      (bottomRight != null && bottomRight != BorderRadius.zero) ||
      (bottomLeft != null && bottomLeft != BorderRadius.zero);

  /// True if any size is non-zero.
  bool get hasSides =>
      (top != null && top != BorderSide.none) ||
      (right != null && right != BorderSide.none) ||
      (bottom != null && bottom != BorderSide.none) ||
      (left != null && left != BorderSide.none);

  // True if all four sides are equal.
  bool get hasUniformSides => top == bottom && top == left && top == right;

  @override
  bool operator ==(o) =>
      o is Border &&
      top == o.top &&
      right == o.right &&
      bottom == o.bottom &&
      left == o.left &&
      topLeft == o.topLeft &&
      topRight == o.topRight &&
      bottomRight == o.bottomRight &&
      bottomLeft == o.bottomLeft;
  @override
  int get hashCode => toString().hashCode;

  static const none = Border();

  /// Mimics the border in Flutter's underline input.
  static const underlineInput = Border.complex(
      bottom: BorderSide(style: BorderStyle.solid, width: 1.0),
      topLeft: BorderRadius(4.0),
      topRight: BorderRadius(4.0));

  /// Mimics the border in Flutter's outline input.
  static const outlineInput = Border(
      sides: BorderSide(style: BorderStyle.solid, width: 1.0),
      radii: BorderRadius(4.0));
}

/// One side of a [Border].
class BorderSide {
  const BorderSide({this.width: 1.0, this.style: BorderStyle.none, this.color});
  final double width;
  final BorderStyle style;
  final Color color;

  /// CSS value.
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

  static const none = BorderSide();
}

/// A corner of a [Border].
class BorderRadius {
  const BorderRadius([double radius = 0.0])
      : x = radius,
        y = radius;
  const BorderRadius.asymmetric(this.x, this.y);
  final double x;
  final double y;

  @override
  String toString() => '${x}px ${y}px';

  @override
  bool operator ==(o) => o is BorderRadius && x == o.x && y == o.y;
  @override
  int get hashCode => toString().hashCode;

  static const zero = BorderRadius(0.0);
}

/// An enum-like class.
class BorderStyle {
  const BorderStyle._(this._name);
  final String _name;

  static const BorderStyle none = BorderStyle._('none');
  static const BorderStyle solid = BorderStyle._('solid');

  /// CSS value.
  @override
  String toString() => _name;
}
