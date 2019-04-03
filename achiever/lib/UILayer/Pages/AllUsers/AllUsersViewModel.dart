import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';

class AllUsersViewModel {
  final List<UserDto> allUsers;
  final bool isLocked;

  final Function refresh;

  final Function follow;
  final Function unfollow;

  AllUsersViewModel({
    this.allUsers,
    this.isLocked,
    this.refresh,
    this.follow,
    this.unfollow
  });

  static AllUsersViewModel fromStore(Store<AppState> store) {
    final state = store.state.userState;

    return AllUsersViewModel(
      allUsers: state.allUsers,
      isLocked: false,
      refresh: () {
        store.dispatch(fetchAllUsers);
      },
      follow: (String id) {
        //store.dispatch(SetTargetId(id));
        store.dispatch(followAndReload(id));
      },
      unfollow: (String id) {
        //store.dispatch(SetTargetId(id));
        store.dispatch(unfollowAndReload(id));
      }
    );
  }
}