import 'dart:html';

import 'package:angular2/core.dart';

import 'package:tidra/models/user.dart';
import 'package:tidra/models/timelog.dart';
import 'package:tidra/models/customer.dart';

import 'package:tidra/services/user.dart';
import 'package:tidra/services/timelog.dart';
import 'package:tidra/services/customer.dart';

@Component(
    templateUrl: 'timelog.html',
    selector: 'timelog',
    providers: const[UserService, TimelogService, CustomerService]
)
class TimelogComponent implements OnInit {
  UserService _userService;
  TimelogService _timelogService;
  CustomerService _customerService;

  User currentUser = new User();
  List<Customer> customers;
  Timelog model = new Timelog();
  bool submitted = false;

  TimelogComponent(this._userService, this._timelogService, this._customerService);

  ngOnInit() async {
    setCurrentUser();
    getCustomers();
  }

  //onDateChange(String value) {
  //  model.date = DateTime.parse(value);
  //}

  onSubmit() async {
    _timelogService.createTimelog(model);
    submitted = true;
  }

  setCurrentUser() async {
    Map<String, dynamic> info = new Map<String, dynamic>();
    info = await this._userService.getUserInformation();

    model.user_id = int.parse(info["user_id"]);
    this.currentUser = await this._userService.getUser(model.user_id);
  }

  getCustomers() async {
    customers = await _customerService.getCustomers();
    model.customer_id = customers.first.id;
  }
}