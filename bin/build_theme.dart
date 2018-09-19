import 'dart:io';
import 'package:abstract_theme/abstract_theme.dart';

void main() async {
  final file = File('lib/_themes.scss');
  await file.writeAsString(Theme.combineThemestoScss(), flush: true);
}
