import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';

import 'package:tidra/config/config.dart';
import 'package:tidra/models/timelog.dart';

@Injectable()
class TimelogService {
  String _url = Config.api;

  Future<List<Timelog>> getTimelogs() async {
    final String response = await HttpRequest.getString(_url + "timelogs");
    final decoded = JSON.decode(response);

    List<Timelog> timelogs = new List<Timelog>();
    decoded.forEach((timelog) => timelogs.add(new Timelog.fromJson(timelog)));

    return timelogs;
  }

  Future<Timelog> getTimelog(int id) async {
    final String response  = await HttpRequest.getString(_url + "timelogs/" + id.toString());
    final decoded = JSON.decode(response);

    return new Timelog.fromJson(decoded);
  }

  Future<bool> createTimelog(Timelog timelog) async {
    var request = new HttpRequest();
    request.open("POST", _url + 'timelogs');
    var data = JSON.encode(timelog);

    await request.send(data);

    return true;
  }
}