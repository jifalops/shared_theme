import 'package:abstract_theme/src/util/themable.dart';

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

  String get cssValue => 'rgba($red, $green, $blue, $alpha)';

  /// Calculates the luminence of this color and considers it dark if below a
  /// certain level. Does *not* take alpha into consideration.
  ///
  /// See https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color
  bool get isDark {
    final luminence = (0.2126 * red + 0.7152 * green + 0.0722 * blue);
    return luminence < 150;
  }

  static Color contrast(Color color) =>
      color.isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
}

/// A contrasting pair of colors, e.g. for text-on-background.
///
/// At least one of [bg] and [fg] must be specified.
class ColorPair extends Themable {
  ColorPair(this.bg) : fg = Color.contrast(bg);
  ColorPair.foreground(this.fg) : bg = Color.contrast(fg);
  const ColorPair.both(this.bg, this.fg);

  /// Background color.
  final Color bg;

  /// Foreground color.
  final Color fg;

  ColorPair copyWith({Color fg, Color bg}) =>
      ColorPair.both(bg ?? this.bg, fg ?? this.fg);

  @override
  Map<String, String> get cssValues => {
        'background-color': bg.cssValue,
        'color': fg.cssValue,
      };
}
