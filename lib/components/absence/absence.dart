// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:tidra/services/user.dart';
import 'package:tidra/services/absence.dart';
import 'package:tidra/services/absence_type.dart';

import 'package:tidra/models/user.dart';
import 'package:tidra/models/absence.dart';
import 'package:tidra/models/absence_type.dart';

@Component(
    selector: 'absence',
    templateUrl: 'absence.html',
    providers: const[UserService, AbsenceService, AbsenceTypeService])
class AbsenceComponent implements OnInit {
  UserService _userService;
  AbsenceService _absenceService;
  AbsenceTypeService _absenceTypeService;

  List<User> users;
  List<AbsenceType> absence_types;
  Absence model = new Absence();
  bool submitted = false;

  AbsenceComponent(this._userService, this._absenceService, this._absenceTypeService);

  ngOnInit() async {
    getUsers();
    getAbsenceTypes();
  }

  getUsers() async {
    users = await _userService.getUsers();
    model.user_id = users.first.id;
  }

  getAbsenceTypes() async {
    absence_types = await _absenceTypeService.getAbsenceTypes();
    model.absence_type_id = absence_types.first.id;
  }

  onSubmit() {
    _absenceService.createAbsence(model);
    submitted = true;
  }
}
