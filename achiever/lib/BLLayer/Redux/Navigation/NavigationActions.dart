class GoToFeedAction {}

class GoToSearchAction {}

class GoToAddAction {}

class GoToNotificationsAction {}

class GoToProfileAction {}

class GoBackAction {}

class SetCurrentRouteNameAction {
  final int index;
  final String name;

  SetCurrentRouteNameAction(
    this.index,
    this.name
  );
}