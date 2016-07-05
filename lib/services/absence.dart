import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:tidra/config/config.dart';

import 'package:tidra/models/absence.dart';

@Injectable()
class AbsenceService {
  String _url = Config.api + "absence";

  Future<bool> createAbsence(Absence absence) async {
    var request = new HttpRequest();
    request.open("POST", _url);

    var data = JSON.encode(absence);

    await request.send(data);

    return true;
  }
}