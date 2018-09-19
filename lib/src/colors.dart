import 'package:meta/meta.dart';
import 'package:shared_theme/src/util/colors.dart';
import 'package:shared_theme/src/util/css.dart';

export 'package:shared_theme/src/util/colors.dart';

/// The named colors in a theme.
class ThemeColors implements CssEntityContainer {
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

  @override
  String asScssMap() => '''(
    primary: ${primary.asScssMap()},
    primaryLight: ${primaryLight.asScssMap()},
    primaryDark: ${primaryDark.asScssMap()},
    secondary: ${secondary.asScssMap()},
    secondaryLight: ${secondaryLight.asScssMap()},
    secondaryDark: ${secondaryDark.asScssMap()},
    background: ${background.asScssMap()},
    surface: ${surface.asScssMap()},
    divider: ${divider.asScssMap()},
    error: ${error.asScssMap()},
    notice: ${notice.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) => <String>[
        primary.asThemifiedMixin('primary-color', parentKeys..add('primary')),
        primaryLight.asThemifiedMixin(
            'primary-color-light', parentKeys..add('primaryLight')),
        primaryDark.asThemifiedMixin(
            'primary-color-dark', parentKeys..add('primaryDark')),
        secondary.asThemifiedMixin(
            'secondary-color', parentKeys..add('secondary')),
        secondaryLight.asThemifiedMixin(
            'secondary-color-light', parentKeys..add('secondaryLight')),
        secondaryDark.asThemifiedMixin(
            'secondary-color-dark', parentKeys..add('secondaryDark')),
        background.asThemifiedMixin(
            'background-color', parentKeys..add('background')),
        surface.asThemifiedMixin('surface-color', parentKeys..add('surface')),
        divider.asThemifiedMixin('divider', parentKeys..add('divider')),
        error.asThemifiedMixin('error', parentKeys..add('error')),
        notice.asThemifiedMixin('notice', parentKeys..add('notice')),
      ];
}
