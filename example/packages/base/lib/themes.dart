import 'package:shared_theme/shared_theme.dart';

final themes = ThemeSet(themes: [
  Theme(
      name: 'Light',
      brightness: Brightness.light,
      colors: _lightColors,
      fonts: _darkFonts,
      elements: _lightElements),
  Theme(
      name: 'Dark',
      brightness: Brightness.dark,
      colors: _darkColors,
      fonts: _lightFonts,
      elements: _darkElements),
], fontFaces: _fontFaces);

/// See the theme colors at https://material.io/tools/color/#!/?view.left=0&view.right=0&secondary.color=651FFF&primary.color=4CAF50
class _ThemeColors extends ColorSet {
  const _ThemeColors({
    ContrastingColors background,
    ContrastingColors surface,
    ContrastingColors divider,
  }) : super(
          primary: const ContrastingColors(Color(0xff4caf50), Colors.black),
          primaryLight:
              const ContrastingColors(Color(0xff80e27e), Colors.black),
          primaryDark: const ContrastingColors(Color(0xff087f23), Colors.white),
          secondary: const ContrastingColors(Color(0xff651fff), Colors.white),
          secondaryLight:
              const ContrastingColors(Color(0xffa255ff), Colors.black),
          secondaryDark:
              const ContrastingColors(Color(0xff0100ca), Colors.white),
          error: const ContrastingColors(Colors.error, Colors.onError),
          notice: const ContrastingColors(Color(0xffff8f00), Colors.black),
          background: background,
          surface: surface,
          divider: divider,
        );
}

const _lightColors = _ThemeColors(
  background: ContrastingColors(Color(0xfffefefe), Colors.black),
  surface: ContrastingColors(Color(0xfffefefe), Colors.black),
  divider: ContrastingColors(Color(0xffeeeeee), Colors.black),
);

const _darkColors = _ThemeColors(
  background: ContrastingColors(Color(0xff333333), Colors.white),
  surface: ContrastingColors(Color(0xff333333), Colors.white),
  divider: ContrastingColors(Color(0xff484848), Colors.white),
);

// The default font set.
final _darkFonts = FontSet(
    headline: FontSet.dark.headline
        .copyWith(weight: 700, height: 2.5, family: 'Ubuntu'),
    title: FontSet.dark.title.copyWith(weight: 700, family: 'Ubuntu'),
    subhead: FontSet.dark.subhead
        .copyWith(size: 18.0, height: 1.75, weight: 300, family: 'Ubuntu'),
    body2: FontSet.dark.body2
        .copyWith(size: 18.0, weight: 600, family: 'Open Sans'),
    body1: FontSet.dark.body1
        .copyWith(size: 16.0, height: 1.15, family: 'Open Sans'),
    caption: FontSet.dark.caption.copyWith(size: 16.0, family: 'Open Sans'),
    button: FontSet.dark.button.copyWith(family: 'Open Sans'));

final _lightFonts = _darkFonts.lighten();

final _buttonBase = Element(
  align: TextAlign.center,
  font: _darkFonts.button.copyWith(size: 16.0, weight: 400),
  padding: BoxSpacing.symmetric(vertical: 4.0, horizontal: 8.0),
  border: Border(radii: BorderRadius(4.0)),
);

final _lightElements = ElementSet(
    primaryButton: _buttonBase.copyWith(
        color: _lightColors.secondary.color,
        font: _buttonBase.font.copyWith(color: _lightColors.secondary.contrast),
        shadow: ShadowElevation.dp8),
    secondaryButton: _buttonBase.copyWith(
        color: _lightColors.primary.color,
        font: _buttonBase.font.copyWith(color: _lightColors.primary.contrast)),
    tertiaryButton: _buttonBase,
    textInput: Element(
      border: Border(
          sides: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: _lightColors.background.contrast)),
    ));

final _darkElements = _lightElements.copyWith(
    tertiaryButton: _lightElements.tertiaryButton.copyWith(
        font: _lightElements.tertiaryButton.font
            .copyWith(color: _lightFonts.button.color)));

final _fontFaces = [
  FontFace(
      family: 'Open Sans',
      url: 'packages/sharedtheme_example/assets/fonts/OpenSans-Regular.ttf'),
  FontFace(
      family: 'Open Sans',
      url: 'packages/sharedtheme_example/assets/fonts/OpenSans-SemiBold.ttf',
      weight: 500),
  FontFace(
      family: 'Open Sans',
      url: 'packages/sharedtheme_example/assets/fonts/OpenSans-Light.ttf',
      weight: 300),
  FontFace(
      family: 'Open Sans',
      url: 'packages/sharedtheme_example/assets/fonts/OpenSans-Bold.ttf',
      weight: 700),
  FontFace(
      family: 'Open Sans',
      url: 'packages/sharedtheme_example/assets/fonts/OpenSans-Italic.ttf',
      style: FontStyle.italic),
  FontFace(
      family: 'Ubuntu',
      url: 'packages/sharedtheme_example/assets/fonts/Ubuntu-Regular.ttf'),
  FontFace(
      family: 'Ubuntu',
      url: 'packages/sharedtheme_example/assets/fonts/Ubuntu-Light.ttf',
      weight: 300),
  FontFace(
      family: 'Ubuntu',
      url: 'packages/sharedtheme_example/assets/fonts/Ubuntu-Bold.ttf',
      weight: 700),
];
