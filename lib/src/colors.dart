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
  ThemeColors.contrast(ThemeColors other)
      : primary = Color.contrast(other.primary),
        primaryLight = Color.contrast(other.primaryLight),
        primaryDark = Color.contrast(other.primaryDark),
        secondary = Color.contrast(other.secondary),
        secondaryLight = Color.contrast(other.secondaryLight),
        secondaryDark = Color.contrast(other.secondaryDark),
        background = Color.contrast(other.background),
        surface = Color.contrast(other.surface),
        divider = Color.contrast(other.divider),
        error = Color.contrast(other.error),
        notice = Color.contrast(other.notice);

  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color secondary;
  final Color secondaryLight;
  final Color secondaryDark;

  final Color background;
  final Color surface;
  final Color divider;

  final Color error;
  final Color notice;

  ThemeColors copyWith({
    Color primary,
    Color primaryLight,
    Color primaryDark,
    Color secondary,
    Color secondaryLight,
    Color secondaryDark,
    Color background,
    Color surface,
    Color divider,
    Color error,
    Color notice,
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
