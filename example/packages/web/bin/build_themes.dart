import 'dart:io';
import 'package:sharedtheme_example/themes.dart';
import 'package:sass/sass.dart' as sass;

void main() async {
  final file = File('lib/_themes.g.scss');
  final scss = themes.toString();
  // sass.compileString(scss);
  await file.writeAsString(scss, flush: true);
}
