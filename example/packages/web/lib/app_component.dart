import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:shared_theme/shared_theme.dart';
import 'package:sharedtheme_example/themes.dart';
import 'src/example_list/example_list.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: [
    'package:angular_components/app_layout/layout.scss.css',
    'app_component.css'
  ],
  templateUrl: 'app_component.html',
  directives: [
    MaterialToggleComponent,
    ExampleList,
  ],
)
class AppComponent implements OnInit {
  Theme theme;
  bool dark;

  @override
  void ngOnInit() {
    /// Get the saved theme, or use a default.
    final name = window.localStorage['theme'];
    if (name != null && name.isNotEmpty) {
      theme = themeset.getThemeByName(name);
    }
    theme ??= themeset.themes.first;
    dark = theme.brightness == Brightness.dark;
    setThemeClass();
  }

  void toggle() {
    dark = !dark;
    theme = themeset
        .getThemeByBrightness(dark ? Brightness.dark : Brightness.light);

    setThemeClass();

    /// Write the theme name to local storage.
    window.localStorage['theme'] = theme.name;
  }

  /// Set the theme class on the `html` element.
  void setThemeClass() => document.documentElement.className = 'theme-${theme.name}';
}
