import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final int counter;

  BasePage(this.title, this.counter);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(
              color: Colors.white
            ),),
            Text(counter.toString(), style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 35
            ),)
            ]
          )
      ),
    );
  }
}