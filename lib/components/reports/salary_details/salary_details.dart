// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:tidra/components/shared/print_button/print_button.dart';
import 'package:tidra/services/salary_details.dart';
import 'package:tidra/services/user.dart';
import 'package:tidra/models/salary_details.dart';
import 'package:tidra/models/user.dart';

@Component(
    selector: 'salary-details',
    templateUrl: 'salary_details.html',
    providers: const[SalaryDetailsService, UserService],
    directives: const[PrintButtonComponent])
class SalaryDetailsComponent implements OnInit {
  SalaryDetailsService _salaryDetailsService;
  UserService _userService;

  SalaryDetails model = new SalaryDetails();
  List<User> users = new List<User>();

  SalaryDetailsComponent(this._salaryDetailsService, this._userService);

  ngOnInit() async {
    getUsers();
  }

  onSubmit() {
    getSalaryDetails(model);
  }

  getUsers() async {
    users = await _userService.getUsers();
    model.user_id = users.first.id;
  }

  getSalaryDetails(SalaryDetails input) async {
    model = await _salaryDetailsService.getSalaryDetails(input.user_id, input.from_date, input.to_date);
  }
}
