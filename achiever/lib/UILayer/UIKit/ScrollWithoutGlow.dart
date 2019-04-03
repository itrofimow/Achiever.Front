import 'package:flutter/material.dart';
import 'NoScrollGlowBehavior.dart';

class ScrollWithoutGlow extends ScrollConfiguration {
  ScrollWithoutGlow({
    @required Widget child
    }) : super(
    child: child, behavior: NoScrollGlowBehavior());
}