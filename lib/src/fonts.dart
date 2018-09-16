import 'package:abstract_theme/src/util/css.dart';
import 'package:abstract_theme/src/util/fonts.dart';

export 'package:abstract_theme/src/util/fonts.dart';

/// The named fonts in a theme.
class ThemeFonts implements CssEntityContainer {
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
        display4.asThemifiedMixin('font-display4', parentKeys..add('display4')),
        display3.asThemifiedMixin('font-display3', parentKeys..add('display3')),
        display2.asThemifiedMixin('font-display2', parentKeys..add('display2')),
        display1.asThemifiedMixin('font-display1', parentKeys..add('display1')),
        headline.asThemifiedMixin('font-headline', parentKeys..add('headline')),
        title.asThemifiedMixin('font-title', parentKeys..add('title')),
        subhead.asThemifiedMixin('font-subhead', parentKeys..add('subhead')),
        body2.asThemifiedMixin('font-body2', parentKeys..add('body2')),
        body1.asThemifiedMixin('font-body1', parentKeys..add('body1')),
        caption.asThemifiedMixin('font-caption', parentKeys..add('caption')),
        button.asThemifiedMixin('font-button', parentKeys..add('button')),
      ];
}
