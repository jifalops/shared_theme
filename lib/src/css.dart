abstract class CssEntity implements ScssMap {
  const CssEntity();

  Map<String, String> get cssValues;

  String asScssMap() {
    final sb = StringBuffer();
    cssValues.forEach((key, value) => sb.writeln('$key: $value,'));
    return '(${sb.toString()})';
  }

  /// Return [cssValues] as a mixin that uses the `themify` SCSS utility.
  String asThemifiedMixin(String name, List<String> parentKeys) {
    var sb = StringBuffer();
    parentKeys.forEach((key) => sb.write("'$key', "));
    final prefix = sb.toString();
    sb = StringBuffer();
    cssValues.keys.forEach((key) => sb.writeln(
        "@if index(\$include, '$key') and not index(\$exclude, '$key') { $key: themed($prefix '$key'); }"));
    return '''
      @mixin $name(\$include: ('${cssValues.keys.join("','")}'), \$exclude: ()) {
        @include themify {
          ${sb.toString()}
        }
      }
      .$name {
        @include $name;
      }
      ''';
  }

  @override
  String toString() => cssValues.entries
      .map((entry) => '${entry.key}: ${entry.value};')
      .join('\n');
}

abstract class MixinAggregator implements ScssMap {
  List<String> getMixins();
}

abstract class CssEntityContainer implements ScssMap {
  List<String> getMixins(List<String> parentKeys);
}

abstract class ScssMap {
  String asScssMap();
}
