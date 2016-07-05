import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:tidra/config/config.dart';

import 'package:tidra/models/absence_type.dart';

@Injectable()
class AbsenceTypeService {
  String _url = Config.api + "absencetypes";

  Future<List<AbsenceType>> getAbsenceTypes() async {
    final String response = await HttpRequest.getString(_url);
    final decoded = JSON.decode(response);

    List<AbsenceType> absenceTypes = new List<AbsenceType>();
    decoded.forEach((absenceType) => absenceTypes.add(new AbsenceType.fromJson(absenceType)));

    return absenceTypes;
  }
}