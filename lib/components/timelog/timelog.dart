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

  List<User> users;
  List<Customer> customers;
  Timelog model = new Timelog();
  bool submitted = false;

  TimelogComponent(this._userService, this._timelogService, this._customerService);

  ngOnInit() async {
    getUsers();
    getCustomers();
  }

  //onDateChange(String value) {
  //  model.date = DateTime.parse(value);
  //}

  onSubmit() async {
    _timelogService.createTimelog(model);
    submitted = true;
  }

  getUsers() async {
    users = await _userService.getUsers();
    model.user_id = users.first.id;
  }

  getCustomers() async {
    customers = await _customerService.getCustomers();
    model.customer_id = customers.first.id;
  }
}