import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/colors.dart';
import 'package:abstract_theme/src/util/themable.dart';

class Font extends Themable {
  const Font({
    @required this.size,
    this.family: 'Roboto',
    this.color: Colors.black87,
    this.height: 1.0,
    this.weight: 400,
    this.style: FontStyle.normal,
    this.decoration: const TextDecoration(),
    this.letterSpacing: 0.0,
    this.wordSpacing: 0.0,
  });

  final double size;
  final String family;
  final Color color;
  final int weight;
  final FontStyle style;
  final TextDecoration decoration;
  final double height;
  final double letterSpacing;
  final double wordSpacing;

  Font copyWith({
    double size,
    String family,
    Color color,
    double height,
    int weight,
    FontStyle style,
    TextDecoration decoration,
    double letterSpacing,
    double wordSpacing,
  }) =>
      Font(
        size: size ?? this.size,
        family: family ?? this.family,
        color: color ?? this.color,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        style: style ?? this.style,
        decoration: decoration ?? this.decoration,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        wordSpacing: wordSpacing ?? this.wordSpacing,
      );

  @override
  Map<String, String> get cssValues => {
        'font': '$style $weight ${size}px/$height $family',
        'text-decoration': '$decoration',
        'color': '${color.cssValue}',
        'letter-spacing': '${letterSpacing}px',
        'word-spacing': '${wordSpacing}px',
      };
}

/// Italic or not.
class FontStyle {
  const FontStyle._(this._name);
  final String _name;

  static const normal = FontStyle._('normal');
  static const italic = FontStyle._('italic');

  /// CSS value
  @override
  toString() => _name;
}

/// Underline, etc.
class TextDecoration {
  const TextDecoration({
    this.lines: const [],
    this.style: TextDecorationStyle.solid,
    this.color,
  });
  final List<TextDecorationLine> lines;
  final TextDecorationStyle style;
  final Color color;

  /// CSS value
  @override
  String toString() => lines.isEmpty
      ? 'none'
      : '${lines.join(' ')} $style ${color?.cssValue ?? ''}';
}

class TextDecorationLine {
  const TextDecorationLine._(this._name);
  final String _name;

  static const underline = TextDecorationLine._('underline');
  static const overline = TextDecorationLine._('overline');
  static const lineThrough = TextDecorationLine._('line-through');

  /// CSS value
  @override
  toString() => _name;
}

class TextDecorationStyle {
  const TextDecorationStyle._(this._name);
  final String _name;

  static const solid = TextDecorationStyle._('solid');
  static const double = TextDecorationStyle._('double');
  static const dotted = TextDecorationStyle._('dotted');
  static const dashed = TextDecorationStyle._('dashed');
  static const wavy = TextDecorationStyle._('wavy');

  /// CSS value
  @override
  toString() => _name;
}

class FontFace {
  const FontFace({
    @required this.family,
    @required this.url,
    this.weight: 400,
    this.style: FontStyle.normal,
  });
  final String family;
  final String url;
  final int weight;
  final FontStyle style;

  String get cssValue => '''
    @font-face {
      font-family: '$family';
      font-weight: $weight;
      src: url('$url') format('${FontFormat.parse(url)}');
    }
''';

  String asCssImport() => '@import url($url);';
  String asHtmlLink() => '<link rel="stylesheet" type="text/css" href="$url">';
}

class FontFormat {
  const FontFormat._(this._name);
  final String _name;

  static const ttf = FontFormat._('truetype');
  static const woff = FontFormat._('woff');
  static const woff2 = FontFormat._('woff2');
  static const eot = FontFormat._('embedded-opentype');
  static const svg = FontFormat._('svg');

  static FontFormat parse(String format) {
    if (format.endsWith('.ttf')) return ttf;
    if (format.endsWith('.woff')) return woff;
    if (format.endsWith('.woff2')) return woff2;
    if (format.endsWith('.eot')) return eot;
    if (format.endsWith('.svg')) return svg;
    return null;
  }

  /// CSS value
  @override
  String toString() => _name;
}

/// Default fonts from material design.
class Fonts {
  // Black fonts.

  /// size: 112.0, weight: 100, color: Colors.black54
  static const display4Black =
      Font(size: 112.0, weight: 100, color: Colors.black54);

  /// size: 56.0, color: Colors.black54
  static const display3Black = Font(size: 56.0, color: Colors.black54);

  /// size: 45.0, color: Colors.black54
  static const display2Black = Font(size: 45.0, color: Colors.black54);

  /// size: 34.0, color: Colors.black54
  static const display1Black = Font(size: 34.0, color: Colors.black54);

  /// size: 24.0
  static const headlineBlack = Font(size: 24.0);

  /// size: 20.0, weight: 500
  static const titleBlack = Font(size: 20.0, weight: 500);

  /// size: 16.0
  static const subheadBlack = Font(size: 16.0);

  /// size: 14.0, weight: 500
  static const body2Black = Font(size: 14.0, weight: 500);

  /// size: 14.0
  static const body1Black = Font(size: 14.0);

  /// size: 12.0, color: Colors.black54
  static const captionBlack = Font(size: 12.0, color: Colors.black54);

  /// size: 14.0, weight: 500
  static const buttonBlack = Font(size: 14.0, weight: 500);

  // White fonts.

  /// size: 112.0, weight: 100, color: Colors.white70
  static const display4White =
      Font(size: 112.0, weight: 100, color: Colors.white70);

  /// size: 56.0, color: Colors.white70
  static const display3White = Font(size: 56.0, color: Colors.white70);

  /// size: 45.0, color: Colors.white70
  static const display2White = Font(size: 45.0, color: Colors.white70);

  /// size: 34.0, color: Colors.white70
  static const display1White = Font(size: 34.0, color: Colors.white70);

  /// size: 24.0, color: Colors.white
  static const headlineWhite = Font(size: 24.0, color: Colors.white);

  /// size: 20.0, weight: 500, color: Colors.white
  static const titleWhite = Font(size: 20.0, weight: 500, color: Colors.white);

  /// size: 16.0, color: Colors.white
  static const subheadWhite = Font(size: 16.0, color: Colors.white);

  /// size: 14.0, weight: 500, color: Colors.white
  static const body2White = Font(size: 14.0, weight: 500, color: Colors.white);

  /// size: 14.0, color: Colors.white
  static const body1White = Font(size: 14.0, color: Colors.white);

  /// size: 12.0, color: Colors.white70
  static const captionWhite = Font(size: 12.0, color: Colors.white70);

  /// size: 14.0, weight: 500, color: Colors.white
  static const buttonWhite = Font(size: 14.0, weight: 500, color: Colors.white);
}
