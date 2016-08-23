// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:tidra/services/user.dart';
import 'package:tidra/models/user.dart';

@Component(
    selector: 'handle-users',
    templateUrl: 'handle_users.html',
    providers: const[UserService])
class HandleUsersComponent implements OnInit {
  UserService _userService;

  List<User> users;
  User existingUser = new User();
  User newUser = new User();
  bool updateSuccess = false;
  bool createSuccess = false;

  HandleUsersComponent(this._userService);

  ngOnInit() async {
    getUsers();
  }

  getUsers() async {
    users = await _userService.getUsers();
    existingUser = users.first;
  }

  onChooseExisting(id) =>
      existingUser = users.firstWhere((user) => user.id == id);

  onUpdate() {
    _userService.updateUser(existingUser);
    updateSuccess = true;
  }

  onCreate() async {
    newUser  = await _userService.createUser(newUser);
    //users.add(newUser);
    createSuccess = true;
  }

}
