import 'package:abstract_theme/src/colors.dart';
import 'package:abstract_theme/src/fonts.dart';
import 'package:abstract_theme/src/util/borders.dart';
import 'package:abstract_theme/src/util/css.dart';

export 'package:abstract_theme/src/colors.dart';
export 'package:abstract_theme/src/fonts.dart';
export 'package:abstract_theme/src/util/borders.dart';
export 'package:abstract_theme/src/util/css.dart';

class Theme implements ScssMap {
  final ThemeColors colors;
  final ThemeFonts fonts;
  final Border buttonBorder;
  final Border inputBorder;

  @override
  String asScssMap() {
    // TODO: implement asScssMap
  }
}

class ThemeSet {
  final List<FontFace> fontFaces;
}
