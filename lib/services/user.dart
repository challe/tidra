import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';

import 'package:tidra/config/config.dart';
import 'package:tidra/models/user.dart';

@Injectable()
class UserService {
  String _url = Config.api();

  Future<List<User>> getUsers() async {
    final String response = await HttpRequest.getString(_url + "users");
    final decoded = JSON.decode(response);

    List<User> users = new List<User>();
    decoded.forEach((user) => users.add(new User.fromJson(user)));

    return users;
  }

  Future<User> getUser(int id) async {
    final String response = await HttpRequest.getString(_url + "users/" + id.toString());
    final decoded = JSON.decode(response);

    return new User.fromJson(decoded);
  }

  Future<User> createUser(User user) async {
    var request = new HttpRequest();
    request.open("POST", _url + 'users');
    var data = JSON.encode(user);

    // TODO: Retrieve the id of the newly created user and add it to user
    var id = await request.send(data);

    return user;
  }

  Future<bool> updateUser(User user) async {
    var request = new HttpRequest();
    request.open("PUT", _url + 'users/' + user.id.toString());
    var data = JSON.encode(user);

    var users = await request.send(data);

    return true;
  }

  Future<Map<String, dynamic>> getUserInformation() async {
    Map<String, dynamic> userInformation = new Map<String, dynamic>();
    Storage localStorage = window.localStorage;
    String token = localStorage['token'];

    if(token != null) {
      final String response = await HttpRequest.getString(_url + "auth/validate/" + token);
      final decoded = JSON.decode(response);

      if(decoded["error"] == false && decoded["valid"] == true) {
        userInformation["is_logged_in"] = true;
        userInformation["is_admin"] = (decoded["is_admin"] == "1") ? true : false;
        userInformation["user_id"] = decoded["user_id"];
      }
    }
    else {
      userInformation["is_logged_in"] = false;
      userInformation["is_admin"] = false;
      userInformation["user_id"] = null;
    }

    return userInformation;
  }
}