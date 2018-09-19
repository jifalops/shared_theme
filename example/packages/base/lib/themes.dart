import 'package:shared_theme/shared_theme.dart';

/// See the theme colors at https://material.io/tools/color/#!/?view.left=0&view.right=0&secondary.color=651FFF&primary.color=4CAF50
class MyThemeColors extends ColorSet {
  const MyThemeColors({
    ContrastingColors background,
    ContrastingColors surface,
    ContrastingColors divider,
  }) : super(
          primary: const ContrastingColors(Color(0xff4caf50), Colors.black87),
          primaryLight:
              const ContrastingColors(Color(0xff80e27e), Colors.black87),
          primaryDark: const ContrastingColors(Color(0xff087f23), Colors.white70),
          secondary: const ContrastingColors(Color(0xff651fff), Colors.white70),
          secondaryLight:
              const ContrastingColors(Color(0xffa255ff), Colors.black87),
          secondaryDark:
              const ContrastingColors(Color(0xff0100ca), Colors.white70),
          error: const ContrastingColors(Colors.error, Colors.onError),
          notice: const ContrastingColors(Color(0xffff8f00), Colors.black87),
          background: background,
          surface: surface,
          divider: divider,
        );
}


// Theme font-sets (only color changes between themes in this app).
final _darkFonts = FontSet(
    headline: Fonts.headlineBlack
        .copyWith(weight: 700, height: 2.5, family: 'Ubuntu'),
    title: Fonts.titleBlack.copyWith(weight: 700, family: 'Ubuntu'),
    subhead: Fonts.subheadBlack
        .copyWith(size: 18.0, height: 1.75, weight: 300, family: 'Ubuntu'),
    body2: Fonts.body2Black.copyWith(
        size: 18.0, weight: 600, family: 'Open Sans'),
    body1: Fonts.body1Black
        .copyWith(size: 16.0, height: 1.15, family: 'Open Sans'),
    caption: Fonts.captionBlack.copyWith(size: 16.0, family: 'Open Sans'),
    button: Fonts.buttonBlack.copyWith(family: 'Open Sans'));

final _lightFonts = FontSet(
  display4: _darkFonts.display4.copyWith(color: Fonts.display4White.color),
  display3: _darkFonts.display3.copyWith(color: Fonts.display3White.color),
  display2: _darkFonts.display2.copyWith(color: Fonts.display2White.color),
  display1: _darkFonts.display1.copyWith(color: Fonts.display1White.color),
  headline: _darkFonts.headline.copyWith(color: Fonts.headlineWhite.color),
  subhead: _darkFonts.subhead.copyWith(color: Fonts.subheadWhite.color),
  body2: _darkFonts.body2, // Uses brand color.
  body1: _darkFonts.body1.copyWith(color: Fonts.body1White.color),
  caption: _darkFonts.caption.copyWith(color: Fonts.captionWhite.color),
  button: _darkFonts.button.copyWith(color: Fonts.buttonWhite.color),
);

const themes = const SharedThemeSet(themes: [
  const SharedTheme(
      name: 'Light',
      colors: MyThemeColors(
        background: ContrastingColors(Color(0xfffefefe), Colors.black),
        surface: ContrastingColors(Color(0xfffefefe), Colors.black),
        divider: ContrastingColors(Color(0xffeeeeee), Colors.black),
      ),
      fonts:
      ),
], fontFaces: []);
