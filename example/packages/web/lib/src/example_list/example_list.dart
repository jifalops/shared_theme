import 'dart:html';
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

    NgFor,
    NgIf,
    NgClass
  ],
)
class ExampleList {
  void showSnackbar() {

  }
}
