import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/fonts.dart';

export 'package:abstract_theme/src/util/fonts.dart';

/// The named fonts in a theme.
class ThemeFonts {
  const ThemeFonts({
    this.display4: Fonts.display4Black,
    this.display3: Fonts.display3Black,
    this.display2: Fonts.display2Black,
    this.display1: Fonts.display1Black,
    this.headline: Fonts.headlineBlack,
    this.title: Fonts.titleBlack,
    this.subhead: Fonts.subheadBlack,
    this.body2: Fonts.body2Black,
    this.body1: Fonts.body1Black,
    this.caption: Fonts.captionBlack,
    this.button: Fonts.buttonBlack,
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
}
