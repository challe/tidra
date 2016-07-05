// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

import 'package:tidra/components/shared/print_button/print_button.dart';
import 'package:tidra/services/invoice_details.dart';
import 'package:tidra/services/customer.dart';
import 'package:tidra/models/invoice_details.dart';
import 'package:tidra/models/customer.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'invoice_details.html',
    providers: const[InvoiceDetailsService, CustomerService],
    directives: const[PrintButtonComponent])
class InvoiceDetailsComponent implements OnInit {
  final InvoiceDetailsService _invoiceDetailsService;
  CustomerService _customerService;

  List<Customer> customers;
  InvoiceDetails model = new InvoiceDetails();

  InvoiceDetailsComponent(this._invoiceDetailsService, this._customerService);

  ngOnInit() async {
    getCustomers();
  }

  onSubmit() {
    getInvoiceDetails(model);
  }

  getCustomers() async {
    customers = await _customerService.getCustomers();
    model.customer_id = customers.first.id;
  }

  getInvoiceDetails(InvoiceDetails input) async {
    model = await _invoiceDetailsService.getInvoiceDetails(input.customer_id, input.from_date, input.to_date);
  }
}