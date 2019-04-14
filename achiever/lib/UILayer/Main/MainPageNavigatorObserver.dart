import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Navigation/NavigationActions.dart';

class MainPageNavigatorObserver extends NavigatorObserver {
  final int index;
  final Store<AppState> store;

  MainPageNavigatorObserver(
    this.index, this.store);

  @override
  void didPop(Route route, Route previousRoute) {
    store.dispatch(SetCurrentRouteNameAction(index, previousRoute.settings.name));
  }

  @override
  void didPush(Route route, Route previousRoute) {
    store.dispatch(SetCurrentRouteNameAction(index, route.settings.name));
  }
}