// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:tidra/components/home/home.dart';
import 'package:tidra/components/timelog/timelog.dart';
import 'package:tidra/components/absence/absence.dart';
import 'package:tidra/components/reports/my_timelog_details/my_timelog_details.dart';
import 'package:tidra/components/reports/invoice_details/invoice_details.dart';
import 'package:tidra/components/reports/salary_details/salary_details.dart';
import 'package:tidra/components/administration/handle_customers/handle_customers.dart';
import 'package:tidra/components/administration/handle_users/handle_users.dart';
import 'package:tidra/components/login/login.dart';
import 'package:tidra/components/logout/logout.dart';
import 'package:tidra/services/user.dart';

import 'package:tidra/auth_router_outlet.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const[CORE_DIRECTIVES, ROUTER_DIRECTIVES, LoggedInRouterOutlet],
    providers: const[UserService])
@RouteConfig(const [
  const Route(path: '/home', name: 'Home', component: HomeComponent, useAsDefault: true),
  const Route(path: '/timelog', name: 'Timelog', component: TimelogComponent),
  const Route(path: '/absence', name: 'Absence', component: AbsenceComponent),
  const Route(path: '/mytimelogdetails', name: 'MyTimelogDetails', component: MyTimelogDetailsComponent),
  const Route(path: '/invoicedetails', name: 'InvoiceDetails', component: InvoiceDetailsComponent),
  const Route(path: '/salarydetails', name: 'SalaryDetails', component: SalaryDetailsComponent),
  const Route(path: '/handlecustomers', name: 'HandleCustomers', component: HandleCustomersComponent),
  const Route(path: '/handleusers', name: 'HandleUsers', component: HandleUsersComponent),
  const Route(path: '/login/:page', name: 'Login', component: LoginComponent),
  const Route(path: '/logout', name: 'Logout', component: LogoutComponent)
])
class AppComponent {
  AppComponent() {
    document..onTouchStart.listen(check)
            ..onClick.listen(check);
  }

  bool checkParent(target, elm) {
    while(target.parent != null) {
      if( target == elm ) { return true; }
      target = target.parent;
    }
    return false;
  }

  void check(Event e) {
    List<Element> menuElements = querySelectorAll(".nav li.dropdown");

    menuElements.forEach((element) {
      if (!checkParent(e.target, element) ) {
        element.classes.remove("open");
      }
    });
  }

  menuClick(Element link) {
    List<Element> tabs = querySelectorAll(".nav li");
    tabs.forEach((tab) => tab.classes..remove("active")..remove("open"));
    Element tab = link.parent;

    if(tab.classes.contains("dropdown")) {
      tab.classes.add("open");
    }
    else {
      tab.classes.add("active");
    }

  }
}

