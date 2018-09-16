import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/css.dart';
import 'package:abstract_theme/src/util/elements.dart';

export 'package:abstract_theme/src/util/elements.dart';

class ThemeElements implements CssEntityContainer {
  const ThemeElements({
    @required this.primaryButton,
    @required this.secondaryButton,
    @required this.tertiaryButton,
    @required this.textInput,
  });
  final Element primaryButton;
  final Element secondaryButton;
  final Element tertiaryButton;
  final Element textInput;

  @override
  String asScssMap() => '''(
    primaryButton: ${primaryButton.asScssMap()},
    secondaryButton: ${secondaryButton.asScssMap()},
    tertiaryButton: ${tertiaryButton.asScssMap()},
    textInput: ${textInput.asScssMap()},
  )''';

  @override
  List<String> getMixins(List<String> parentKeys) => <String>[
        primaryButton.asThemifiedMixin(
            'primary-button', parentKeys..add('primaryButton')),
        secondaryButton.asThemifiedMixin(
            'secondary-button', parentKeys..add('secondaryButton')),
        tertiaryButton.asThemifiedMixin(
            'tertiary-button', parentKeys..add('tertiaryButton')),
        textInput.asThemifiedMixin('text-input', parentKeys..add('textInput')),
      ];
}
