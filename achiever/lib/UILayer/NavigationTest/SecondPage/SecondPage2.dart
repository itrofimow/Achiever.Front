import 'package:flutter/material.dart';

import '../BasePage.dart';

class SecondPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BasePage('SecondPage', 2),
    );
  }
}