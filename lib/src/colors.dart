import 'package:meta/meta.dart';
import 'package:shared_theme/src/css.dart';

/// A color in the red-green-blue scheme with optional alpha.
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
///
/// The colors can both be `null` to use platform defaults such as a base theme
/// color in Flutter or "inherit" for CSS.
class ContrastingColors extends CssEntity {
  const ContrastingColors(this.color, this.contrast);

  /// The main color, usually used as a background.
  final Color color;

  /// A color that contrasts [color].
  final Color contrast;

  /// Swap [color] and [contrast].
  ContrastingColors invert() => ContrastingColors(contrast, color);

  /// Uses [color] for the CSS `background-color`, and [contrast] for the CSS
  /// `color`.
  @override
  Map<String, String> get cssValues => {
        'background-color': color?.toString() ?? 'inherit',
        'color': contrast?.toString() ?? 'inherit',
      };

  /// Both colors are `null`.
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

/// Material design Font colors with opacity.
class Colors {
  Colors._();
  static const transparent = const Color(0x00000000);
  static const black = const Color(0xFF000000);
  static const black87 = const Color(0xDD000000);
  static const black54 = const Color(0x8A000000);
  static const black45 = const Color(0x73000000);
  static const black38 = const Color(0x61000000);
  static const black26 = const Color(0x42000000);
  static const black12 = const Color(0x1F000000);
  static const white = const Color(0xFFFFFFFF);
  static const white70 = const Color(0xB3FFFFFF);
  static const white30 = const Color(0x4DFFFFFF);
  static const white24 = const Color(0x3DFFFFFF);
  static const white12 = const Color(0x1FFFFFFF);
  static const white10 = const Color(0x1AFFFFFF);
  static const error = Color(0xFFB00020);

  /// Text on top of [error].
  static const onError = Colors.white;
}
