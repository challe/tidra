import 'dart:html';

class Customer {
  int id;
  String name;
  DateTime created;

  Customer();

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["name"] = this.name;
    map["created"] = this.created;

    return map;
  }

  factory Customer.fromJson(Map<String, dynamic> input) {
    Customer c = new Customer()
      ..id = input["id"]
      ..name = input["name"]
      ..created = input["created"];

    return c;
  }
}