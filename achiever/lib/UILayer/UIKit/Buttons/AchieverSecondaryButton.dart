import 'package:flutter/material.dart';

class AchieverSecondaryButton extends StatelessWidget {
  final String text;
  final Function onTap;
  Color color;
  double leftRightMargin;
  bool makeTransparent;

  AchieverSecondaryButton({
    @required this.text,
    @required this.onTap,
    this.color,
    this.leftRightMargin,
    this.makeTransparent
  }) {
    this.color = color ?? Color.fromARGB(255, 51, 51, 51);
    this.leftRightMargin = leftRightMargin ?? 16;
    this.makeTransparent = makeTransparent ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final editButton = GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: makeTransparent ? Colors.transparent : Color.fromARGB(255, 242, 242, 242)
          ),
          height: 36,
          child: Center(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.only(left: leftRightMargin, right: leftRightMargin),
              child: Text(text, style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.22,
                fontWeight: FontWeight.w500,
                color: color
              )),
            ),
          ),
        ),
      ),
      onTap: onTap,
    );

    return editButton;
  }
}