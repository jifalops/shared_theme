import 'package:meta/meta.dart';
import 'package:shared_theme/src/colors.dart';
import 'package:shared_theme/src/css.dart';

class Font extends CssEntity {
  const Font({
    this.size: 16.0,
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
        'font': '$style $weight ${size}px $family',
        'line-height': '$height',
        'text-decoration': '$decoration',
        'color': color.toString(),
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
      : '${lines.join(' ')} $style ${color?.toString() ?? ''}';
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

/// A CSS `@font-face` definition.
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

  /// CSS `@font-face` value.
  @override
  String toString() => '''
    @font-face {
      font-family: '$family';
      font-weight: $weight;
      font-style: $style;
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
    return FontFormat._('');
  }

  /// CSS value
  @override
  String toString() => _name;
}

/// The named fonts in a theme.
class FontSet implements CssEntityContainer {
  const FontSet({
    this.display4: _Fonts.display4Black,
    this.display3: _Fonts.display3Black,
    this.display2: _Fonts.display2Black,
    this.display1: _Fonts.display1Black,
    this.headline: _Fonts.headlineBlack,
    this.title: _Fonts.titleBlack,
    this.subhead: _Fonts.subheadBlack,
    this.body2: _Fonts.body2Black,
    this.body1: _Fonts.body1Black,
    this.caption: _Fonts.captionBlack,
    this.button: _Fonts.buttonBlack,
  });

  final Font display4;
  final Font display3;
  final Font display2;
  final Font display1;
  final Font headline;
  final Font title;
  final Font subhead;
  final Font body2;
  final Font body1;
  final Font caption;
  final Font button;

  /// Copy this FontSet and replace each font's color with a corresponding
  /// color from [FontSet.dark].
  FontSet darken() => FontSet(
      display4: display4.copyWith(color: FontSet.dark.display4.color),
      display3: display3.copyWith(color: FontSet.dark.display3.color),
      display2: display2.copyWith(color: FontSet.dark.display2.color),
      display1: display1.copyWith(color: FontSet.dark.display1.color),
      headline: headline.copyWith(color: FontSet.dark.headline.color),
      title: title.copyWith(color: FontSet.dark.title.color),
      subhead: subhead.copyWith(color: FontSet.dark.subhead.color),
      body2: body2.copyWith(color: FontSet.dark.body2.color),
      body1: body1.copyWith(color: FontSet.dark.body1.color),
      caption: caption.copyWith(color: FontSet.dark.caption.color),
      button: button.copyWith(color: FontSet.dark.button.color));

  /// Copy this FontSet and replace each font's color with a corresponding
  /// color from [FontSet.light].
  FontSet lighten() => FontSet(
      display4: display4.copyWith(color: FontSet.light.display4.color),
      display3: display3.copyWith(color: FontSet.light.display3.color),
      display2: display2.copyWith(color: FontSet.light.display2.color),
      display1: display1.copyWith(color: FontSet.light.display1.color),
      headline: headline.copyWith(color: FontSet.light.headline.color),
      title: title.copyWith(color: FontSet.light.title.color),
      subhead: subhead.copyWith(color: FontSet.light.subhead.color),
      body2: body2.copyWith(color: FontSet.light.body2.color),
      body1: body1.copyWith(color: FontSet.light.body1.color),
      caption: caption.copyWith(color: FontSet.light.caption.color),
      button: button.copyWith(color: FontSet.light.button.color));

  FontSet copyWith({
    Font display4,
    Font display3,
    Font display2,
    Font display1,
    Font headline,
    Font title,
    Font subhead,
    Font body2,
    Font body1,
    Font caption,
    Font button,
  }) =>
      FontSet(
        display4: display4 ?? this.display4,
        display3: display3 ?? this.display3,
        display2: display2 ?? this.display2,
        display1: display1 ?? this.display1,
        headline: headline ?? this.headline,
        title: title ?? this.title,
        subhead: subhead ?? this.subhead,
        body2: body2 ?? this.body2,
        body1: body1 ?? this.body1,
        caption: caption ?? this.caption,
        button: button ?? this.button,
      );

  @override
  String asScssMap() => '''(
    display4: ${display4.asScssMap()},
    display3: ${display3.asScssMap()},
    display2: ${display2.asScssMap()},
    display1: ${display1.asScssMap()},
    headline: ${headline.asScssMap()},
    title: ${title.asScssMap()},
    subhead: ${subhead.asScssMap()},
    body2: ${body2.asScssMap()},
    body1: ${body1.asScssMap()},
    caption: ${caption.asScssMap()},
    button: ${button.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) => <String>[
        display4.asThemifiedMixin(
            'font-display4', List.from(parentKeys)..add('display4')),
        display3.asThemifiedMixin(
            'font-display3', List.from(parentKeys)..add('display3')),
        display2.asThemifiedMixin(
            'font-display2', List.from(parentKeys)..add('display2')),
        display1.asThemifiedMixin(
            'font-display1', List.from(parentKeys)..add('display1')),
        headline.asThemifiedMixin(
            'font-headline', List.from(parentKeys)..add('headline')),
        title.asThemifiedMixin(
            'font-title', List.from(parentKeys)..add('title')),
        subhead.asThemifiedMixin(
            'font-subhead', List.from(parentKeys)..add('subhead')),
        body2.asThemifiedMixin(
            'font-body2', List.from(parentKeys)..add('body2')),
        body1.asThemifiedMixin(
            'font-body1', List.from(parentKeys)..add('body1')),
        caption.asThemifiedMixin(
            'font-caption', List.from(parentKeys)..add('caption')),
        button.asThemifiedMixin(
            'font-button', List.from(parentKeys)..add('button')),
      ];

  static const dark = FontSet();

  static const light = FontSet(
    display4: _Fonts.display4White,
    display3: _Fonts.display3White,
    display2: _Fonts.display2White,
    display1: _Fonts.display1White,
    headline: _Fonts.headlineWhite,
    title: _Fonts.titleWhite,
    subhead: _Fonts.subheadWhite,
    body2: _Fonts.body2White,
    body1: _Fonts.body1White,
    caption: _Fonts.captionWhite,
    button: _Fonts.buttonWhite,
  );
}

/// Default fonts from material design.
class _Fonts {
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
