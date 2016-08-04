import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:http/browser_client.dart';
import 'package:http/http.dart';

import 'package:angular2/angular2.dart';
import 'package:tidra/config/config.dart';
import 'package:tidra/models/auth.dart';

@Injectable()
class AuthService {
  final BrowserClient _http;
  String _url = Config.api();
  Auth auth;

  AuthService(this._http);

  Future<Auth> authenticate(Auth auth) async {
    try {
      final response = await _http.post(_url + "auth",
          headers: {'Content-Type': 'application/json'},
          body: JSON.encode(auth));
      return new Auth.fromJson(_extractData(response));
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response res) {
    var body = JSON.decode(res.body);
    return body['data'] ?? body;
  }

  Exception _handleError(dynamic e) {
    return new Exception('Server error; cause: $e');
  }
}