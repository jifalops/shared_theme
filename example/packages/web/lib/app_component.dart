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
  void setTheme(bool dark) async {
    final theme = dark ? 'Dark' : 'Light';
    document.documentElement.className = 'theme-$theme';
  }
}
