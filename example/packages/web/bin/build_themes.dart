import 'dart:io';
import 'package:sharedtheme_example/themes.dart';

void main() async {
  await File('lib/src/_themes.g.scss').writeAsString(themeset.toString(), flush: true);
}
