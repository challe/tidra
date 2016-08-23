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
    selector: 'my-timelog-details',
    templateUrl: 'my_timelog_details.html',
    providers: const[SalaryDetailsService, UserService],
    directives: const[PrintButtonComponent])
class MyTimelogDetailsComponent implements OnInit {
  SalaryDetailsService _salaryDetailsService;
  UserService _userService;

  SalaryDetails model = new SalaryDetails();
  User currentUser = new User();

  MyTimelogDetailsComponent(this._salaryDetailsService, this._userService);

  ngOnInit() async {
    setCurrentUser();
  }

  onSubmit() {
    getSalaryDetails(model);
  }

  setCurrentUser() async {
    Map<String, dynamic> info = new Map<String, dynamic>();
    info = await this._userService.getUserInformation();

    model.user_id = int.parse(info["user_id"]);
    this.currentUser = await this._userService.getUser(model.user_id);
  }

  getSalaryDetails(SalaryDetails input) async {
    model = await _salaryDetailsService.getSalaryDetails(input.user_id, input.from_date, input.to_date);
  }
}
