import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Models/Notifications/AchieverNotification.dart';

class NotificationsViewModel {
  final List<AchieverNotification> notifications;

  final Function fetchNotifications;

  NotificationsViewModel({
    this.notifications,
    this.fetchNotifications
  });

  static NotificationsViewModel fromStore(Store<AppState> store) {
    final state = store.state.userState;

    return NotificationsViewModel(
      notifications: state.notifications,
      fetchNotifications: () => store.dispatch(fetchAllNotifications)
    );
  }
}