import 'package:meta/meta.dart';
import 'package:abstract_theme/src/util/elements.dart';

class ThemeElements {
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
}
