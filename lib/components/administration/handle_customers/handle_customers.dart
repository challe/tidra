// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:tidra/services/customer.dart';
import 'package:tidra/models/customer.dart';

@Component(
    selector: 'handle-customers',
    templateUrl: 'handle_customers.html',
    providers: const[CustomerService])
class HandleCustomersComponent implements OnInit {
  CustomerService _customerService;

  List<Customer> customers;
  Customer existingCustomer = new Customer();
  Customer newCustomer = new Customer();
  bool updateSuccess = false;
  bool createSuccess = false;

  HandleCustomersComponent(this._customerService);

  ngOnInit() async {
    getCustomers();
  }

  getCustomers() async {
    customers = await _customerService.getCustomers();
    existingCustomer = customers.first;
  }

  onChooseExisting(id) =>
    existingCustomer = customers.firstWhere((customer) => customer.id == id);

  onUpdate() {
    _customerService.updateCustomer(existingCustomer);
    updateSuccess = true;
  }

  onCreate() {
    _customerService.createCustomer(newCustomer);
    createSuccess = true;
  }
}
