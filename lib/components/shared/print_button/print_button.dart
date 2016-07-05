// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/angular2.dart';

@Component(
    selector: 'print-button',
    templateUrl: 'print_button.html',
    styles: const ['''
      button {
        margin-bottom: 15px;
      }
    '''
    ])
class PrintButtonComponent {
  PrintButtonComponent();

  printPage() {
    window.print();
  }
}