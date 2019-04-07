import 'package:redux/redux.dart';

import 'NavigationState.dart';
import 'NavigationActions.dart';

import 'package:achiever/BLLayer/Redux/Keys.dart';

final navigationReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, GoToFeedAction>(_goToFeed),
  TypedReducer<NavigationState, GoToSearchAction>(_goToSearch),
  TypedReducer<NavigationState, GoToAddAction>(_goToAdd),
  TypedReducer<NavigationState, GoToNotificationsAction>(_goToNotifications),
  TypedReducer<NavigationState, GoToProfileAction>(_goToProfile),
  TypedReducer<NavigationState, GoBackAction>(_goBack),
  TypedReducer<NavigationState, SetCurrentRouteNameAction>(_setCurrentRouteName)
]);

NavigationState _goToFeed(NavigationState state, GoToFeedAction action) =>
  _processNavigation(state, NavigationIndexes.feedNavigationIndex);

NavigationState _goToSearch(NavigationState state, GoToSearchAction action) => 
  _processNavigation(state, NavigationIndexes.searchNavigationIndex);

NavigationState _goToAdd(NavigationState state, GoToAddAction action) => 
  _processNavigation(state, NavigationIndexes.addNavigationIndex);

NavigationState _goToNotifications(NavigationState state, GoToNotificationsAction action) => 
  _processNavigation(state, NavigationIndexes.notificationsNavigationIndex);

NavigationState _goToProfile(NavigationState state, GoToProfileAction action) => 
  _processNavigation(state, NavigationIndexes.profileNavigationIndex);

NavigationState _processNavigation(NavigationState state, int newNavigationIndex) {
  final newStack = List<int>.from(state.navigatorsStack);
  newStack.removeWhere((x) => x == newNavigationIndex);
  newStack.add(newNavigationIndex);

  return state.copyWith(
    currentNavigationIndex: newNavigationIndex,
    navigatorsStack: newStack
  );
}

NavigationState _goBack(NavigationState state, GoBackAction action) {
  final newStack = List<int>.from(state.navigatorsStack);

  newStack.removeLast();
  final newLast = newStack.last;

  return state.copyWith(
    currentNavigationIndex: newLast,
    navigatorsStack: newStack
  );
}

NavigationState _setCurrentRouteName(NavigationState state, SetCurrentRouteNameAction action) {
  final names = List<String>.from(state.currentRoute);
  names[action.index] = action.name;

  return state.copyWith(currentRoute: names);
}

