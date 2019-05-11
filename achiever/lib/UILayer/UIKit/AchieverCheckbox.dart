import 'package:flutter/material.dart';

class AchieverCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  AchieverCheckbox({
    @required this.value,
    @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      child: GestureDetector(
        child: Image.asset(value 
          ? 'assets/checkbox_checked.png'
          : 'assets/checkbox_unchecked.png'),
        onTap: () => onChanged(value ^ true),
      ),
    );
  }
}