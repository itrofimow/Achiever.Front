import 'package:flutter/material.dart';
import '../BasePage.dart';

import 'FirstPage2.dart';

class FirstPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BasePage('FirstPage', 1),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(
            name: 'inner'
          ),
          builder: (_) => FirstPage2()
        )),
    );
  }
}