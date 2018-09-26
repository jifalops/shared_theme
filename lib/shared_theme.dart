/// *Write your themes once and easily use them in Flutter and on the web.*
///
/// ### Theme
///
/// A [Theme] is a [ColorSet], [FontSet], and an [ElementSet], which
/// are abstract containers for defining properties such as border, padding, etc.
///
/// ### ThemeSet
///
/// Themes are typically combined into a single [ThemeSet] per application. The
/// ThemeSet adds support for bundled [FontFace]s, and [ThemeSet.toString()]
/// returns an SCSS string that fully represents the ThemeSet.
///
/// ## Example
///
/// There is a [complete example](https://github.com/jifalops/shared_theme/tree/master/example)
/// included, and in particular, see its
/// [ThemeSet definition](https://github.com/jifalops/shared_theme/blob/master/example/packages/base/lib/themes.dart).
library shared_theme;

import 'package:meta/meta.dart';
import 'package:shared_theme/src/css.dart';
import 'package:shared_theme/src/colors.dart';
import 'package:shared_theme/src/fonts.dart';
import 'package:shared_theme/src/elements.dart';

export 'package:shared_theme/src/colors.dart';
export 'package:shared_theme/src/fonts.dart';
export 'package:shared_theme/src/elements.dart';

/// The colors, fonts, and elements in a theme.
class Theme implements MixinAggregator {
  const Theme({
    @required this.name,
    @required this.brightness,
    @required this.colors,
    @required this.fonts,
    @required this.elements,
  })  : assert(name != null),
        assert(colors != null),
        assert(fonts != null),
        assert(elements != null);

  final String name;
  final Brightness brightness;
  final ColorSet colors;
  final FontSet fonts;
  final ElementSet elements;

  @override
  String asScssMap() => '''(
    name: $name,
    brightness: $brightness,
    colors: ${colors.asScssMap()},
    fonts: ${fonts.asScssMap()},
    elements: ${elements.asScssMap()},
  )''';

  @override
  List<String> getMixins() => colors.getMixins(['colors'])
    ..addAll(fonts.getMixins(['fonts']))
    ..addAll(elements.getMixins(['elements']));
}

/// A collection of themes and font-faces.
class ThemeSet implements MixinAggregator {
  const ThemeSet({@required this.themes, this.fontFaces: const []})
      : assert(themes != null),
        assert(fontFaces != null);

  final List<Theme> themes;
  final List<FontFace> fontFaces;

  Theme getTheme(String name) =>
      themes.firstWhere((theme) => theme.name == name, orElse: () => null);

  @override
  String asScssMap() =>
      '(' +
      themes.map((theme) => '${theme.name}: ${theme.asScssMap()}').join(', ') +
      ')';

  @override
  List<String> getMixins() => themes.first.getMixins();

  List<String> getFontFaces() {
    final list = <String>[];
    fontFaces.forEach((fontFace) => list.add(fontFace.toString()));
    return list;
  }

  /// SCSS output that fully represents this set of themes.
  @override
  String toString() => '''
    //
    // Global map of themes.
    //
    \$themes: ${asScssMap()} !global;

    //
    // Font faces
    //
    ${getFontFaces().join('')}

    //
    // Themify utility
    //
    @import 'package:shared_theme/themify';

    //
    // Functions
    //

    /// Get a main color of the current theme.
    /// Can only be used within a `@themify` block.
    @function theme-color(\$themeColorName) {
      @return themed('colors', \$themeColorName, 'background-color');
    }

    /// Get a main color of the current theme.
    /// Can only be used within a `@themify` block.
    @function theme-contrast(\$themeColorName) {
      @return themed('colors', \$themeColorName, 'color');
    }

    //
    // Mixins
    //

    /// Use a theme color as the foreground and contrast as the background.
    @mixin invert-colors(\$themeColorName) {
      @include themify {
        color: theme-color(\$themeColorName);
        background-color: theme-contrast(\$themeColorName);
      }
    }

    ${getMixins().join('')}
  ''';
}

/// An enum-like class.
class Brightness {
  const Brightness._(this._name);
  final String _name;
  @override
  toString() => _name;
  static const light = Brightness._('light');
  static const dark = Brightness._('dark');
}
