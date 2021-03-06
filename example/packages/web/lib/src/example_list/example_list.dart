import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'example-list',
  styleUrls: ['example_list.css'],
  templateUrl: 'example_list.html',
  directives: [
    MaterialButtonComponent,
    MaterialListComponent,
    MaterialListItemComponent,
    materialInputDirectives,
  ],
)
class ExampleList {
  void showSnackbar() {
    print('Snackbar is not an AngularDart component.');
  }
}
