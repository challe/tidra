import 'package:intl/intl.dart';

class SalaryDetailsDay {
  DateTime day;
  String get dayAsString => new DateFormat('yyyy-MM-dd').format(day);
  String day_name;
  int hours_worked;
  bool sjuk;
  bool vab;
  bool sem;

  SalaryDetailsDay();

  factory SalaryDetailsDay.fromJson(Map<String, dynamic> input) {
    SalaryDetailsDay d = new SalaryDetailsDay()
    ..day = DateTime.parse(input["day"])
    ..day_name = input["day_name"]
    ..hours_worked = input["hours_worked"]
    ..sjuk = input["sjuk"]
    ..vab = input["vab"]
    ..sem = input["sem"];

    return d;
  }
}