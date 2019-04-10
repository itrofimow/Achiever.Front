import 'package:flutter/material.dart';

class AchieverButton extends StatelessWidget {
  final double height;
  final Text text;
  final VoidCallback onPressed;

  AchieverButton(this.height, 
    this.text, this.onPressed);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: height,
        decoration : BoxDecoration(
          borderRadius: new BorderRadius.circular(17.0),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 200, 255),
              Color.fromARGB(255, 0, 140, 255)]),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.22),
              offset: Offset(0.0, 12),
              blurRadius: 14.0)
          ]
        ),
        child: Center(
          child: text,
        ),
      ),
      onTap: onPressed,
    );
  }

  factory AchieverButton.createDefault(Text text, VoidCallback onPressed) => AchieverButton(56, text, onPressed);
}