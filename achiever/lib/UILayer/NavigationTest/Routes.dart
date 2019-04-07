import 'package:flutter/material.dart';

import 'FirstPage/FirstPage1.dart';
import 'FirstPage/FirstPage2.dart';

import 'SecondPage/SecondPage1.dart';

class TestNavigationRoutes {
  static final routes = {
    'first': (BuildContext context) => FirstPage1(),
    'first2': (BuildContext context) => FirstPage2(),
    'second': (BuildContext context) => SecondPage1()
  };
}