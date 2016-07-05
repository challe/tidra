import 'dart:html';
class User {
  int id;
  String name;
  String email;
  String password;
  DateTime created;
  int hours_worked;

  User();

  factory User.fromJson(Map<String, dynamic> input) {
    User u = new User()
      ..id = input["id"]
      ..name = input["name"]
      ..created = input["created"];

    if(input.containsKey("hours_worked")) u.hours_worked = input["hours_worked"];

    return u;
  }
}