import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
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
class AppComponent {
  bool dark = window.localStorage['theme'] == 'Dark';

  void toggle() {
    dark = !dark;
    final name = dark ? 'Dark' : 'Light';
    document.documentElement.className = 'theme-$name';
    window.localStorage['theme'] = name;
  }
}
