import 'package:flutter/material.dart';
import '../BasePage.dart';

import 'SecondPage2.dart';

class SecondPage1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BasePage('SecondPage', 1),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SecondPage2()
        )
      ),
    );
  }
}