import 'package:intl/intl.dart';
import 'package:tidra/models/salary_details_day.dart';

class SalaryDetails {
  int user_id;
  String user_name;
  String from_date;
  String to_date;
  int hours;
  int kilometers;
  int sjuk;
  int vab;
  int sem;

  List<SalaryDetailsDay> days;

  SalaryDetails() {
    DateTime now = new DateTime.now();
    DateTime firstDayOfMonth = new DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = new DateTime(now.year,now.month + 1,0);
    DateFormat formatter = new DateFormat('yyyy-MM-dd');

    this.from_date = formatter.format(firstDayOfMonth);
    this.to_date = formatter.format(lastDayOfMonth);

    days = new List<SalaryDetailsDay>();
  }

  factory SalaryDetails.fromJson(Map<String, dynamic> input) {
    SalaryDetails s = new SalaryDetails()
      ..user_id = input["0"]["user_id"]
      ..user_name = input["0"]["user_name"]
      ..from_date = input["0"]["from_date"]
      ..to_date = input["0"]["to_date"]
      ..hours = input["0"]["hours"]
      ..kilometers = input["0"]["kilometers"]
      ..sjuk = input["0"]["sjuk"]
      ..vab = input["0"]["vab"]
      ..sem = input["0"]["sem"];

    input["days"].forEach((day) => s.days.add(new SalaryDetailsDay.fromJson(day)));

    return s;
  }
}