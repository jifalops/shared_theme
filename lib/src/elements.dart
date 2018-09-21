import 'package:shared_theme/src/css.dart';
import 'package:shared_theme/src/fonts.dart';
import 'package:shared_theme/src/colors.dart';

/// Combines color, font, margin, padding, border, shadow, and text align.
class Element extends CssEntity {
  const Element({
    this.color: Colors.transparent,
    this.font: const Font(),
    this.border: const Border(),
    this.margin: const BoxSpacing(),
    this.padding: const BoxSpacing(),
    this.shadow: ShadowElevation.none,
    this.align: TextAlign.start,
    this.size: const SizeLimits(),
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
  Map<String, String> get cssValues => {
        'background-color': color.toString(),
        'margin': margin.toString(),
        'padding': padding.toString(),
        'text-align': align.toString(),
        'box-shadow': '(${shadow.toString()})',
      }
        ..addAll(font.cssValues)
        ..addAll(border.cssValues)
        ..addAll(size.cssValues);
}

class SizeLimits extends CssEntity {
  const SizeLimits(
      {this.minHeight: 0.0,
      this.maxHeight: 0.0,
      this.minWidth: 0.0,
      this.maxWidth: 0.0});
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

  /// CSS value
  @override
  String toString() => '${top}px ${right}px ${bottom}px ${left}px';

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

class Border extends CssEntity {
  const Border(
      {BorderSide sides: BorderSide.none,
      BorderRadius radii: BorderRadius.zero})
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
            '${topLeft.x}px ${topRight.x}px ${bottomLeft.x}px ${bottomRight.x}px / ${topLeft.y}px ${topRight.y}px ${bottomLeft.y}px ${bottomRight.y}px',
      };

  /// True if any corners have a non-zero radius.
  bool get hasRadius =>
      topLeft != BorderRadius.zero ||
      topRight != BorderRadius.zero ||
      bottomRight != BorderRadius.zero ||
      bottomLeft != BorderRadius.zero;

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
  static const flutterUnderlineInput = Border.complex(
    top: BorderSide.none,
    right: BorderSide.none,
    bottom: BorderSide.none,
    left: BorderSide.none,
    topLeft: BorderRadius(4.0),
    topRight: BorderRadius(4.0),
    bottomRight: BorderRadius.zero,
    bottomLeft: BorderRadius.zero,
  );
  static const flutterOutlineInput =
      Border(sides: BorderSide.none, radii: BorderRadius(4.0));
  static const flutterDefaultInput = flutterUnderlineInput;
}

class BorderSide {
  const BorderSide(
      {this.width: 0.0,
      this.style: BorderStyle.none,
      this.color: Colors.transparent});
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

  static const none = BorderSide();
}

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

class BorderStyle {
  const BorderStyle._(this._name);
  final String _name;

  static const BorderStyle none = BorderStyle._('none');
  static const BorderStyle solid = BorderStyle._('solid');

  /// CSS value
  @override
  String toString() => _name;
}

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
