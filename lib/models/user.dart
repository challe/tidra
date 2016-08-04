import 'dart:html';
class User {
  int id;
  String name;
  String username;
  String password;
  DateTime created;
  int hours_worked;

  User();

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["username"] = this.username;
    map["password"] = this.password;
    map["created"] = this.created;

    return map;
  }

  factory User.fromJson(Map<String, dynamic> input) {
    User u = new User()
      ..id = input["id"]
      ..name = input["name"]
      ..created = input["created"];

    if(input.containsKey("hours_worked")) u.hours_worked = input["hours_worked"];

    return u;
  }
}