import 'package:intl/intl.dart';

class Absence {
  int absence_type_id;
  int user_id;
  String from_date;
  String to_date;

  Absence() {
    DateTime now = new DateTime.now();
    DateTime start = now.add(new Duration(days:-1));
    DateTime stop = now;
    DateFormat formatter = new DateFormat('yyyy-MM-dd');

    this.from_date = formatter.format(start);
    this.to_date = formatter.format(stop);
  }

  Map toJson() {
    Map map = new Map();
    map["absence_type_id"] = this.absence_type_id;
    map["user_id"] = this.user_id;
    map["from_date"] = this.from_date;
    map["to_date"] = this.to_date;

    return map;
  }
}