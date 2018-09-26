// For a complete working example, see https://github.com/jifalops/shared_theme/example/packages/
import 'package:shared_theme/shared_theme.dart';

/// See the theme colors at
/// https://material.io/tools/color/#!/?view.left=1&view.right=0&secondary.color=FFAB00&primary.color=2E7D32
final themeset = ThemeSet(themes: [
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

// Declaring common theme colors here allows you to refer to them as a default
// value in contructors.
const _primary = ContrastingColors(Color(0xff2e7d32), Colors.white);
const _primaryLight = ContrastingColors(Color(0xff60ad5e), Colors.black);
const _primaryDark = ContrastingColors(Color(0xff005005), Colors.white);
const _secondary = ContrastingColors(Color(0xffffab00), Colors.black);
const _secondaryLight = ContrastingColors(Color(0xffffdd4b), Colors.black);
const _secondaryDark = ContrastingColors(Color(0xffc67c00), Colors.black);
const _error = ContrastingColors(Colors.error, Colors.onError);
const _notice = ContrastingColors(Color(0xffb39ddb), Colors.black);

/// This helps define [ColorSet]s that share the same colors (e.g. brand colors).
class _ThemeColors extends ColorSet {
  const _ThemeColors({
    ContrastingColors background,
    ContrastingColors surface,
    ContrastingColors divider,
  }) : super(
          primary: _primary,
          primaryLight: _primaryLight,
          primaryDark: _primaryDark,
          secondary: _secondary,
          secondaryLight: _secondaryLight,
          secondaryDark: _secondaryDark,
          error: _error,
          notice: _notice,
          background: background,
          scaffold: surface,
          dialog: surface,
          card: surface,
          divider: divider,
          selectedRow: divider,
          indicator: _secondary,
          textSelection: _primaryLight,
          textSelectionHandle: _primaryDark,
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

final _baseFonts = FontSet.dark.apply(family: 'Open Sans');

// The default font set.
final _darkFonts = _baseFonts.copyWith(
    headline: FontSet.dark.headline
        .copyWith(weight: 700, height: 2.5, family: 'Ubuntu'),
    title: FontSet.dark.title.copyWith(weight: 700, family: 'Ubuntu'),
    subhead: FontSet.dark.subhead
        .copyWith(size: 18.0, height: 1.75, weight: 300, family: 'Ubuntu'),
    body2: FontSet.dark.body2.copyWith(size: 18.0, weight: 600),
    body1: FontSet.dark.body1.copyWith(size: 16.0, height: 1.15),
    caption: FontSet.dark.caption.copyWith(size: 16.0));

// Copy and apply the corresponding light color to each font.
final _lightFonts = _darkFonts.lighten();

class _ButtonBase extends Element {
  _ButtonBase(
      {Color color: Colors.transparent,
      Font font,
      ShadowElevation shadow: ShadowElevation.none})
      : super(
            align: TextAlign.center,
            padding: BoxSpacing.symmetric(vertical: 4.0, horizontal: 8.0),
            border: Border(radii: BorderRadius(4.0)),
            font: font ?? _darkFonts.button,
            shadow: shadow,
            color: color);
}

/// Default elements.
final _lightElements = ElementSet(
  primaryButton: _ButtonBase(
      color: _lightColors.secondary.color,
      font: _darkFonts.button
          .copyWith(color: _lightColors.secondary.contrast, size: 16.0),
      shadow: ShadowElevation.dp8),
  secondaryButton: _ButtonBase(
      color: _lightColors.primary.color,
      font: _darkFonts.button.copyWith(color: _lightColors.primary.contrast)),
  tertiaryButton: _ButtonBase(),
  inputBase: Element.outlineInput,
);

/// Same as [_lightElements] but with a different text color on the tertiary button.
final _darkElements = _lightElements.copyWith(
    tertiaryButton: _lightElements.tertiaryButton.copyWith(
        font: _lightElements.tertiaryButton.font
            .copyWith(color: _lightFonts.button.color)));

/// These will be included in the CSS, and someday into clients' Flutter app,
/// but for now they must be copied into your Flutter app's pubspec.yaml. The
/// URL is exactly the same though.
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


void main() {
  /// A very long string.
  print(themeset.toString());
}