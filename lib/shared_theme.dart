import 'package:meta/meta.dart';
import 'package:shared_theme/src/util/css.dart';
import 'package:shared_theme/src/colors.dart';
import 'package:shared_theme/src/fonts.dart';
import 'package:shared_theme/src/elements.dart';

export 'package:shared_theme/src/colors.dart';
export 'package:shared_theme/src/fonts.dart';
export 'package:shared_theme/src/elements.dart';

class Theme implements MixinAggregator {
  const Theme({
    @required this.name,
    @required this.colors,
    @required this.fonts,
    @required this.elements,
  })  : assert(name != null),
        assert(colors != null),
        assert(fonts != null),
        assert(elements != null);

  final String name;
  final ThemeColors colors;
  final ThemeFonts fonts;
  final ThemeElements elements;

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

class Themes implements MixinAggregator {
  const Themes({@required this.themes, this.fontFaces: const []})
      : assert(themes != null),
        assert(fontFaces != null);

  final List<Theme> themes;
  final List<FontFace> fontFaces;

  @override
  String asScssMap() =>
      '(' +
      themes.map((theme) => '${theme.name}: ${theme.asScssMap()}').join(', ') +
      ')';

  @override
  List<String> getMixins() {
    final list = <String>[];
    themes.forEach((theme) => list.addAll(theme.getMixins()));
    return list;
  }

  List<String> getFontFaces() {
    final list = <String>[];
    fontFaces.forEach((fontFace) => list.add(fontFace.toString()));
    return list;
  }

  /// SCSS output that fully represents this ThemeSet.
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
