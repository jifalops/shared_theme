import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/colors.dart';

export 'package:abstract_theme/src/util/colors.dart';

/// The named colors in a theme.
class ThemeColors {
  const ThemeColors({
    @required this.primary,
    @required this.primaryLight,
    @required this.primaryDark,
    @required this.secondary,
    @required this.secondaryLight,
    @required this.secondaryDark,
    @required this.background,
    @required this.surface,
    @required this.divider,
    @required this.error,
    @required this.notice,
  });

  final ColorPair primary;
  final ColorPair primaryLight;
  final ColorPair primaryDark;
  final ColorPair secondary;
  final ColorPair secondaryLight;
  final ColorPair secondaryDark;

  final ColorPair background;
  final ColorPair surface;
  final ColorPair divider;

  final ColorPair error;
  final ColorPair notice;

  ThemeColors copyWith({
    ColorPair primary,
    ColorPair primaryLight,
    ColorPair primaryDark,
    ColorPair secondary,
    ColorPair secondaryLight,
    ColorPair secondaryDark,
    ColorPair background,
    ColorPair surface,
    ColorPair divider,
    ColorPair error,
    ColorPair notice,
  }) =>
      ThemeColors(
        primary: primary ?? this.primary,
        primaryLight: primaryLight ?? this.primaryLight,
        primaryDark: primaryDark ?? this.primaryDark,
        secondary: secondary ?? this.secondary,
        secondaryLight: secondaryLight ?? this.secondaryLight,
        secondaryDark: secondaryDark ?? this.secondaryDark,
        background: background ?? this.background,
        surface: surface ?? this.surface,
        divider: divider ?? this.divider,
        error: error ?? this.error,
        notice: notice ?? this.notice,
      );
}
