import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:tidra/config/config.dart';
import 'package:tidra/models/customer.dart';

@Injectable()
class CustomerService {
  String _url = Config.api;

  Future<List<Customer>> getCustomers() async {
    final String response = await HttpRequest.getString(_url + "customers");
    final decoded = JSON.decode(response);

    List<Customer> customers = new List<Customer>();
    decoded.forEach((customer) => customers.add(new Customer.fromJson(customer)));

    return customers;
  }

  Future<Customer> getCustomer(int id) async {
    final String response = await HttpRequest.getString(_url + "customers/" + id.toString());
    final decoded = JSON.decode(response);

    return new Customer.fromJson(decoded);
  }

  Future<List<Customer>> createCustomer(Customer customer) async {
    var request = new HttpRequest();
    request.open("POST", _url + 'customers');
    var data = JSON.encode(customer);

    var customers = await request.send(data);

    return customers;
  }

  Future<bool> updateCustomer(Customer customer) async {
    var request = new HttpRequest();
    request.open("PUT", _url + 'customers/' + customer.id.toString());
    var data = JSON.encode(customer);

    var customers = await request.send(data);

    return true;
  }
}