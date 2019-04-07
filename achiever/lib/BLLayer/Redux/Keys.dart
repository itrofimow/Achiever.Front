import 'package:flutter/material.dart';

class Keys {
  static final baseNavigatorKey = GlobalKey<NavigatorState>();

  static final mainPageNavigators = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
}

class NavigationIndexes {
  static final feedNavigationIndex = 0;
  static final searchNavigationIndex = 1;
  static final addNavigationIndex = 2;
  static final notificationsNavigationIndex = 3;
  static final profileNavigationIndex = 4;
}