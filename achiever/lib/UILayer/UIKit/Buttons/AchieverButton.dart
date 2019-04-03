import 'package:flutter/material.dart';

class AchieverButton extends Container {
  AchieverButton(double minWidth, double height, 
    Text text, VoidCallback onPressed) : super(
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
    child: MaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      minWidth: minWidth,
      height: height,
      child: text,
      onPressed: onPressed,
    )
  );

  factory AchieverButton.createDefault(Text text, VoidCallback onPressed) => AchieverButton(340, 56, text, onPressed);
}