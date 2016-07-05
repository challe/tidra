import 'package:intl/intl.dart';

class Timelog {
  int id;
  String date;
  int user_id;
  String user_name;
  int customer_id;
  String customer_name;
  int hours;
  int minutes;
  int kilometers;
  String text;
  DateTime created;

  Timelog() {
    this.date = new DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = this.id;
    map["date"] = this.date.toString();
    map["user_id"] = this.user_id;
    map["user_name"] = this.user_name;
    map["customer_id"] = this.customer_id;
    map["customer_name"] = this.customer_name;
    map["hours"] = this.hours;
    map["minutes"] = this.minutes;
    map["kilometers"] = this.kilometers;
    map["text"] = this.text;
    map["created"] = this.created.toString();

    return map;
  }

  factory Timelog.fromJson(Map<String, dynamic> input) {
    Timelog t = new Timelog()
      ..id = input["id"]
      ..date = input["date"]
      ..user_id = input["user_id"]
      ..user_name = input["user_name"]
      ..customer_id = input["customer_id"]
      ..customer_name = input["customer_name"]
      ..hours = input["hours"]
      ..minutes = input["minutes"]
      ..kilometers = input["kilometers"]
      ..text = input["text"]
      ..created = input["created"];

    return t;
  }
}