import 'dart:html';
import 'package:angular2/angular2.dart';

@Component(
    selector: 'logout',
    templateUrl: 'logout.html')
class LogoutComponent implements OnInit {
  LogoutComponent();

  ngOnInit() {
    Storage localStorage = window.localStorage;
    localStorage.clear();
  }
}