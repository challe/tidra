import 'dart:html';
import 'package:tidra/models/user.dart';
import 'package:intl/intl.dart';

class InvoiceDetails {
  int customer_id;
  String from_date;
  String to_date;
  int hours_total;
  int kilometers_total;
  int hours_period;
  int kilometers_period;

  List<User> users_involved;

  InvoiceDetails() {
    DateTime now = new DateTime.now();
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = new DateTime(now.year,now.month + 1,0);
    DateFormat formatter = new DateFormat('yyyy-MM-dd');

    this.from_date = formatter.format(firstDayOfMonth);
    this.to_date = formatter.format(lastDayOfMonth);
    this.users_involved = new List<User>();
  }

  factory InvoiceDetails.fromJson(Map<String, dynamic> input) {
    InvoiceDetails i = new InvoiceDetails()
      ..customer_id = input["0"]["customer_id"]
      ..from_date = input["0"]["from_date"]
      ..to_date = input["0"]["to_date"]
      ..hours_total = input["0"]["hours_total"]
      ..kilometers_total = input["0"]["kilometers_total"]
      ..hours_period = input["0"]["hours_period"]
      ..kilometers_period = input["0"]["kilometers_period"];

    input["users"].forEach((user) => i.users_involved.add(new User.fromJson(user)));

    return i;
  }
}