// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modified by Jacob Phillips in July 2018.

import 'package:abstract_theme/src/util/color.dart';
export 'package:abstract_theme/src/util/color.dart';

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
