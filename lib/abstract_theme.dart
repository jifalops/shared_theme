import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/css.dart';
import 'package:abstract_theme/src/colors.dart';
import 'package:abstract_theme/src/fonts.dart';
import 'package:abstract_theme/src/elements.dart';

export 'package:abstract_theme/src/colors.dart';
export 'package:abstract_theme/src/fonts.dart';
export 'package:abstract_theme/src/elements.dart';

class Theme implements CssEntityContainer {
  const Theme({
    @required this.colors,
    @required this.fonts,
    @required this.elements,
  });
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
  List<String> getMixins(List<String> parentKeys) =>
      colors.getMixins(['colors'])
        ..addAll(fonts.getMixins(['fonts']))
        ..addAll(elements.getMixins(['elements']));
}

class ThemeSet implements CssEntityContainer {
  final List<Theme> themes;
  final List<FontFace> fontFaces;

  @override
  String asScssMap() => '''(
    colors: ${colors.asScssMap()},
    fonts: ${fonts.asScssMap()},
    elements: ${elements.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) =>
      colors.getMixins(['colors'])
        ..addAll(fonts.getMixins(['fonts']))
        ..addAll(elements.getMixins(['elements']));
}
