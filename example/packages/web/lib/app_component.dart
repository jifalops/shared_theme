import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

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
    MaterialButtonComponent,
    MaterialIconComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    NgFor,
    NgIf,
    NgClass
  ],
)
class AppComponent implements OnInit {
  final list = '''
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  '''.split(' ');

  @override
  void ngOnInit() async {
//    showSplash = (await res.resources.splash.get()) ?? false;
//    initialized = true;
  }

  void setTheme(String theme) async {
    document.documentElement.className = 'theme-$theme';
    window.localStorage['theme'] = theme;
  }

  void toggleSplash() async {
//    final value = !(await resources.splash.get());
//    resources.splash.write(value.toString());
  }
}
