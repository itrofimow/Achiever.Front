import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';

@immutable
class NavigationState {
  final int currentNavigationIndex;
  final List<int> navigatorsStack;
  final List<String> currentRoute;

  NavigationState({
    this.currentNavigationIndex,
    this.navigatorsStack,
    this.currentRoute
  });

  NavigationState copyWith({
    int currentNavigationIndex,
    List<int> navigatorsStack,
    List<String> currentRoute
  }) {
    return NavigationState(
      currentNavigationIndex: currentNavigationIndex ?? this.currentNavigationIndex,
      navigatorsStack: navigatorsStack ?? this.navigatorsStack,
      currentRoute: currentRoute ?? this.currentRoute
    );
  }

  factory NavigationState.initial() {
    return NavigationState(
      currentNavigationIndex: NavigationIndexes.feedNavigationIndex,
      navigatorsStack: [NavigationIndexes.feedNavigationIndex],
      currentRoute: ['feed', 'search', 'add', 'notifications', 'profile']
    );
  }
}