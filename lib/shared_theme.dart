/// It is recommended you import this library using the `as` directive, e.g.
/// `import 'package:shared_theme/shared_theme' as themer;`
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
    // Themes global map
    \$themes: ${asScssMap()} !global;

    // Font faces
    ${getFontFaces().join('')}

    // Themify utility
    @import 'package:shared_theme/themify';

    // Mixins
    ${getMixins().join('')}
  ''';
}

enum Brightness { light, dark }
