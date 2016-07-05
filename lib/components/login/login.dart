// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:tidra/models/auth.dart';
import 'package:tidra/services/auth.dart';

@Component(
    selector: 'login',
    templateUrl: 'login.html',
    providers: const[AuthService])
class LoginComponent implements OnInit {
  Storage localStorage = window.localStorage;
  Router _router;
  RouteParams _routeParams;
  AuthService _authService;
  String _page;
  Auth model = new Auth();

  LoginComponent(this._authService, this._routeParams, this._router);

  ngOnInit() {
    this._page = this._routeParams.get("page");
  }

  onSubmit() async {
    Auth auth = await _authService.authenticate(model);

    if(auth.error == false) {
      localStorage['token'] = auth.token;
      this._router.root.navigateByUrl(this._page);
    }
  }
}
