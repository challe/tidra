// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


import 'package:angular2/platform/browser.dart';
import 'package:http/browser_client.dart';
import 'package:angular2/router.dart' show ROUTER_PROVIDERS;
import 'package:angular2/platform/common.dart';

import 'package:tidra/components/app_component/app_component.dart';

import 'package:angular2/core.dart';

BrowserClient HttpClientBackendServiceFactory() => new BrowserClient();

main() {
  bootstrap(AppComponent, const [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(BrowserClient,
        useFactory: HttpClientBackendServiceFactory, deps: const [])
  ]);

}
