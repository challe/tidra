import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';

import 'package:tidra/config/config.dart';
import 'package:tidra/models/invoice_details.dart';

@Injectable()
class InvoiceDetailsService {
  static const String _url = Config.api + "invoicedetails/";

  Future<InvoiceDetails> getInvoiceDetails(int customer_id, String from_date, String to_date) async {
    final String response = await HttpRequest.getString(_url + customer_id.toString() + "/" + from_date + "/" + to_date);
    final decoded = JSON.decode(response);
    return new InvoiceDetails.fromJson(decoded);
  }
}