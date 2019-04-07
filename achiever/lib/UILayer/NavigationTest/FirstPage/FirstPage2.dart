import 'package:flutter/material.dart';

import '../BasePage.dart';

class FirstPage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BasePage('FirstPage', 2),
    );
  }
}