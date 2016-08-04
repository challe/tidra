import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:tidra/config/config.dart';

import 'package:tidra/models/salary_details.dart';

@Injectable()
class SalaryDetailsService {
  String _url = Config.api() + "salarydetails/";

  Future<SalaryDetails> getSalaryDetails(int user_id, String from_date, String to_date) async {
    final String response = await HttpRequest.getString(_url + user_id.toString() + "/" + from_date + "/" + to_date);
    final decoded = JSON.decode(response);

    SalaryDetails salaryDetails = new SalaryDetails.fromJson(decoded);

    return salaryDetails;
  }
}