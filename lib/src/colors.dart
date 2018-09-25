import 'package:meta/meta.dart';
import 'package:shared_theme/src/css.dart';

/// Platform independent representation of a color in the red-green-blue scheme
/// with an optional alpha (opacity) component.
class Color {
  /// Alpha Red Green Blue.
  final int argb;

  /// ARGB format.
  const Color(this.argb);

  /// Construct a [Color] from parts.
  const Color.from({int red: 0, int green: 0, int blue: 0, double alpha = 1.0})
      : assert(red >= 0 && red <= 0xFF),
        assert(green >= 0 && green <= 0xFF),
        assert(blue >= 0 && blue <= 0xFF),
        assert(alpha >= 0 && alpha <= 1),
        argb =
            (((alpha * 0xFF) ~/ 1) << 24) | (red << 16) | (green << 8) | blue;

  double get alpha => alphaByte / 0xFF;
  int get alphaByte => (argb >> 24) & 0xFF;
  int get red => (argb >> 16) & 0xFF;
  int get green => (argb >> 8) & 0xFF;
  int get blue => argb & 0xFF;

  int get rgb => argb & 0xFFFFFF;
  int get rgba => (rgb << 8) & alphaByte;

  /// CSS value
  @override
  String toString() => 'rgba($red, $green, $blue, $alpha)';

  /// Calculates the luminence of this color and considers it dark if below a
  /// certain level. Does *not* take alpha into consideration.
  ///
  /// See https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color
  bool get isDark {
    final luminence = (0.2126 * red + 0.7152 * green + 0.0722 * blue);
    return luminence < 150;
  }

  /// White or black, depending on [isDark].
  Color get contrast => isDark ? Colors.white : Colors.black;

  @override
  bool operator ==(o) => o is Color && o.argb == argb;
  @override
  int get hashCode => argb.hashCode;
}

/// A color and its contrast.
class ContrastingColors extends CssEntity {
  const ContrastingColors(this.color, this.contrast);

  /// The main color, usually used as a background.
  final Color color;

  /// The color that contrasts [color].
  final Color contrast;

  ContrastingColors invert() => ContrastingColors(contrast, color);

  /// Uses [color] for the CSS `background-color`, and [contrast] for the CSS
  /// `color`.
  @override
  Map<String, String> get cssValues => {
        'background-color': color?.toString() ?? 'inherit',
        'color': contrast?.toString() ?? 'inherit',
      };

  static const none = ContrastingColors(null, null);
}

/// The named colors in a theme.
class ColorSet implements CssEntityContainer {
  const ColorSet({
    @required this.primary,
    @required this.primaryLight,
    @required this.primaryDark,
    @required this.secondary,
    this.secondaryLight: ContrastingColors.none,
    this.secondaryDark: ContrastingColors.none,
    this.background: ContrastingColors.none,
    this.scaffold: ContrastingColors.none,
    this.dialog: ContrastingColors.none,
    this.card: ContrastingColors.none,
    this.divider: ContrastingColors.none,
    this.error: const ContrastingColors(Colors.error, Colors.onError),
    this.notice: ContrastingColors.none,
    this.indicator: ContrastingColors.none,
    this.hint: ContrastingColors.none,
    this.splash: ContrastingColors.none,
    this.selectedRow: ContrastingColors.none,
    this.highlight: ContrastingColors.none,
    this.textSelectionHandle: ContrastingColors.none,
    this.textSelection: ContrastingColors.none,
  });

  final ContrastingColors primary;
  final ContrastingColors primaryLight;
  final ContrastingColors primaryDark;
  final ContrastingColors secondary;
  final ContrastingColors secondaryLight;
  final ContrastingColors secondaryDark;

  final ContrastingColors background;
  final ContrastingColors divider;
  final ContrastingColors error;
  final ContrastingColors notice;

  final ContrastingColors indicator;
  final ContrastingColors hint;
  final ContrastingColors splash;
  final ContrastingColors selectedRow;
  final ContrastingColors highlight;
  final ContrastingColors textSelection;
  final ContrastingColors textSelectionHandle;
  final ContrastingColors scaffold;
  final ContrastingColors dialog;
  final ContrastingColors card;

  ColorSet copyWith({
    ContrastingColors primary,
    ContrastingColors primaryLight,
    ContrastingColors primaryDark,
    ContrastingColors secondary,
    ContrastingColors secondaryLight,
    ContrastingColors secondaryDark,
    ContrastingColors background,
    ContrastingColors divider,
    ContrastingColors error,
    ContrastingColors notice,
    ContrastingColors textSelection,
    ContrastingColors textSelectionHandle,
    ContrastingColors highlight,
    ContrastingColors indicator,
    ContrastingColors hint,
    ContrastingColors splash,
    ContrastingColors selectedRow,
    ContrastingColors scaffold,
    ContrastingColors dialog,
    ContrastingColors card,
  }) =>
      ColorSet(
        primary: primary ?? this.primary,
        primaryLight: primaryLight ?? this.primaryLight,
        primaryDark: primaryDark ?? this.primaryDark,
        secondary: secondary ?? this.secondary,
        secondaryLight: secondaryLight ?? this.secondaryLight,
        secondaryDark: secondaryDark ?? this.secondaryDark,
        background: background ?? this.background,
        divider: divider ?? this.divider,
        error: error ?? this.error,
        notice: notice ?? this.notice,
        indicator: indicator ?? this.indicator,
        hint: hint ?? this.hint,
        splash: splash ?? this.splash,
        selectedRow: selectedRow ?? this.selectedRow,
        highlight: highlight ?? this.highlight,
        textSelectionHandle: textSelectionHandle ?? this.textSelectionHandle,
        textSelection: textSelection ?? this.textSelection,
        scaffold: scaffold ?? this.scaffold,
        dialog: dialog ?? this.dialog,
        card: card ?? this.card,
      );

  @override
  String asScssMap() => '''(
    primary: ${primary.asScssMap()},
    primaryLight: ${primaryLight.asScssMap()},
    primaryDark: ${primaryDark.asScssMap()},
    secondary: ${secondary.asScssMap()},
    secondaryLight: ${secondaryLight.asScssMap()},
    secondaryDark: ${secondaryDark.asScssMap()},
    background: ${background.asScssMap()},
    scaffold: ${scaffold.asScssMap()},
    card: ${card.asScssMap()},
    dialog: ${dialog.asScssMap()},
    divider: ${divider.asScssMap()},
    error: ${error.asScssMap()},
    notice: ${notice.asScssMap()},
    indicator: ${indicator.asScssMap()},
    hint: ${hint.asScssMap()},
    splash: ${splash.asScssMap()},
    selectedRow: ${selectedRow.asScssMap()},
    highlight: ${highlight.asScssMap()},
    textSelection: ${textSelection.asScssMap()},
    textSelectionHandle: ${textSelectionHandle.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) => <String>[
        primary.asThemifiedMixin(
            'primary-color', List.from(parentKeys)..add('primary')),
        primaryLight.asThemifiedMixin(
            'primary-color-light', List.from(parentKeys)..add('primaryLight')),
        primaryDark.asThemifiedMixin(
            'primary-color-dark', List.from(parentKeys)..add('primaryDark')),
        secondary.asThemifiedMixin(
            'secondary-color', List.from(parentKeys)..add('secondary')),
        secondaryLight.asThemifiedMixin('secondary-color-light',
            List.from(parentKeys)..add('secondaryLight')),
        secondaryDark.asThemifiedMixin('secondary-color-dark',
            List.from(parentKeys)..add('secondaryDark')),
        background.asThemifiedMixin(
            'background-color', List.from(parentKeys)..add('background')),
        scaffold.asThemifiedMixin(
            'scaffold-color', List.from(parentKeys)..add('scaffold')),
        dialog.asThemifiedMixin(
            'dialog-color', List.from(parentKeys)..add('dialog')),
        card.asThemifiedMixin('card-color', List.from(parentKeys)..add('card')),
        divider.asThemifiedMixin(
            'divider-color', List.from(parentKeys)..add('divider')),
        error.asThemifiedMixin(
            'error-color', List.from(parentKeys)..add('error')),
        notice.asThemifiedMixin(
            'notice-color', List.from(parentKeys)..add('notice')),
        indicator.asThemifiedMixin(
            'indicator-color', List.from(parentKeys)..add('indicator')),
        hint.asThemifiedMixin('hint-color', List.from(parentKeys)..add('hint')),
        splash.asThemifiedMixin(
            'splash-color', List.from(parentKeys)..add('splash')),
        selectedRow.asThemifiedMixin(
            'selected-row-color', List.from(parentKeys)..add('selectedRow')),
        highlight.asThemifiedMixin(
            'highlight-color', List.from(parentKeys)..add('highlight')),
        textSelection.asThemifiedMixin('text-selection-color',
            List.from(parentKeys)..add('textSelection')),
        textSelectionHandle.asThemifiedMixin('text-selection-handle-color',
            List.from(parentKeys)..add('textSelectionHandle')),
      ];
}

// The Following static colors (mostly black and white with varying opacities)
// were taken from the Flutter SDK and added to. In an attempt to respect
// copyright, the entire file is below, limited modification.
// ============================================================================

// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modified by Jacob Phillips in July 2018.

/// [Color] and [ColorSwatch] constants which represent Material design's
/// [color palette](http://material.google.com/style/color.html).
///
/// Instead of using an absolute color from these palettes, consider using
/// [Theme.of] to obtain the local [ThemeData] structure, which exposes the
/// colors selected for the current theme, such as [ThemeData.primaryColor] and
/// [ThemeData.accentColor] (among many others).
///
/// Most swatches have colors from 100 to 900 in increments of one hundred, plus
/// the color 50. The smaller the number, the more pale the color. The greater
/// the number, the darker the color. The accent swatches (e.g. [redAccent]) only
/// have the values 100, 200, 400, and 700.
///
/// In addition, a series of blacks and whites with common opacities are
/// available. For example, [black54] is a pure black with 54% opacity.
///
/// ## Sample code
///
/// To select a specific color from one of the swatches, index into the swatch
/// using an integer for the specific color desired, as follows:
///
/// ```dart
/// Color selection = Colors.green[400]; // Selects a mid-range green.
/// ```
///
/// Each [ColorSwatch] constant is a color and can used directly. For example:
///
/// ```dart
/// new Container(
///   color: Colors.blue, // same as Colors.blue[500] or Colors.blue.shade500
/// )
/// ```
///
/// ## Color palettes
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.pink.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.pinkAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.red.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.redAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.deepOrange.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.deepOrangeAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.orange.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.orangeAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.amber.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.amberAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.yellow.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.yellowAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lime.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.limeAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightGreen.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightGreenAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.green.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.greenAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.teal.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.tealAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.cyan.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.cyanAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightBlue.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.lightBlueAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blue.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blueAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.indigo.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.indigoAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.purple.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.purpleAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.deepPurple.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.deepPurpleAccent.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blueGrey.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.brown.png)
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.grey.png)
///
/// ## Blacks and whites
///
/// These colors are identified by their transparency. The low transparency
/// levels (e.g. [Colors.white12] and [Colors.white10]) are very hard to see and
/// should be avoided in general. They are intended for very subtle effects.
///
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
/// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
///
/// The [Colors.transparent] color isn't shown here because it is entirely
/// invisible!
class Colors {
  Colors._();

  /// Completely invisible.
  static const Color transparent = const Color(0x00000000);

  /// Completely opaque black.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [black87], [black54], [black45], [black38], [black26], [black12], which
  ///    are variants on this color but with different opacities.
  ///  * [white], a solid white color.
  ///  * [transparent], a fully-transparent color.
  static const Color black = const Color(0xFF000000);

  /// Black with 87% opacity.
  ///
  /// This is a good contrasting color for text in light themes.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [Typography.black], which uses this color for its text styles.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [black], [black54], [black45], [black38], [black26], [black12], which
  ///    are variants on this color but with different opacities.
  static const Color black87 = const Color(0xDD000000);

  /// Black with 54% opacity.
  ///
  /// This is a color commonly used for headings in light themes. It's also used
  /// as the mask color behind dialogs.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [Typography.black], which uses this color for its text styles.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [black], [black87], [black45], [black38], [black26], [black12], which
  ///    are variants on this color but with different opacities.
  static const Color black54 = const Color(0x8A000000);

  /// Black with 45% opacity.
  ///
  /// Used for disabled icons.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [black], [black87], [black54], [black38], [black26], [black12], which
  ///    are variants on this color but with different opacities.
  static const Color black45 = const Color(0x73000000);

  /// Black with 38% opacity.
  ///
  /// Used for the placeholder text in data tables in light themes.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [black], [black87], [black54], [black45], [black26], [black12], which
  ///    are variants on this color but with different opacities.
  static const Color black38 = const Color(0x61000000);

  /// Black with 26% opacity.
  ///
  /// Used for disabled radio buttons and the text of disabled flat buttons in light themes.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// See also:
  ///
  ///  * [ThemeData.disabledColor], which uses this color by default in light themes.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [black], [black87], [black54], [black45], [black38], [black12], which
  ///    are variants on this color but with different opacities.
  static const Color black26 = const Color(0x42000000);

  /// Black with 12% opacity.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.blacks.png)
  ///
  /// Used for the background of disabled raised buttons in light themes.
  ///
  /// See also:
  ///
  ///  * [black], [black87], [black54], [black45], [black38], [black26], which
  ///    are variants on this color but with different opacities.
  static const Color black12 = const Color(0x1F000000);

  /// Completely opaque white.
  ///
  /// This is a good contrasting color for the [ThemeData.primaryColor] in the
  /// dark theme. See [ThemeData.brightness].
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// See also:
  ///
  ///  * [Typography.white], which uses this color for its text styles.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [white70, white30, white12, white10], which are variants on this color
  ///    but with different opacities.
  ///  * [black], a solid black color.
  ///  * [transparent], a fully-transparent color.
  static const Color white = const Color(0xFFFFFFFF);

  /// White with 70% opacity.
  ///
  /// This is a color commonly used for headings in dark themes.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// See also:
  ///
  ///  * [Typography.white], which uses this color for its text styles.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [white, white30, white12, white10], which are variants on this color
  ///    but with different opacities.
  static const Color white70 = const Color(0xB3FFFFFF);

  /// White with 32% opacity.
  ///
  /// Used for disabled radio buttons and the text of disabled flat buttons in dark themes.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// See also:
  ///
  ///  * [ThemeData.disabledColor], which uses this color by default in dark themes.
  ///  * [Theme.of], which allows you to select colors from the current theme
  ///    rather than hard-coding colors in your build methods.
  ///  * [white, white70, white12, white10], which are variants on this color
  ///    but with different opacities.
  static const Color white30 = const Color(0x4DFFFFFF);

  /// White with 24% opacity.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// Used for the splash color for filled buttons.
  ///
  /// See also:
  ///
  ///  * [white, white70, white30, white10], which are variants on this color
  ///    but with different opacities.
  static const Color white24 = const Color(0x3DFFFFFF);

  /// White with 12% opacity.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// Used for the background of disabled raised buttons in dark themes.
  ///
  /// See also:
  ///
  ///  * [white, white70, white30, white10], which are variants on this color
  ///    but with different opacities.
  static const Color white12 = const Color(0x1FFFFFFF);

  /// White with 10% opacity.
  ///
  /// ![](https://flutter.github.io/assets-for-api-docs/assets/material/Colors.whites.png)
  ///
  /// See also:
  ///
  ///  * [white, white70, white30, white12], which are variants on this color
  ///    but with different opacities.
  ///  * [transparent], a fully-transparent color, not far from this one.
  static const Color white10 = const Color(0x1AFFFFFF);

  /// The default error color from material design.
  static const error = Color(0xFFB00020);

  /// Text on top of [error].
  static const onError = Colors.white;
}
