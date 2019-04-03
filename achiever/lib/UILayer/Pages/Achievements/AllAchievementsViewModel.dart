import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Redux/Achievements/AllAchievementsActions.dart';
import 'dart:async';

class AllAchievementsViewModel {
  final List<Achievement> allAchievements;
  final isLoading;

  final Function updateList;

  AllAchievementsViewModel({
    this.allAchievements,
    this.isLoading,
    this.updateList
  });

  static AllAchievementsViewModel fromStore(Store<AppState> store) {
    final state = store.state.allAchievementsState;

    return AllAchievementsViewModel(
      allAchievements: state.achievements,
      isLoading: state.isLoading,
      updateList: () {
        final completer = Completer<Null>();
        store.dispatch(fetchAllAchievementsAction(completer));

        return completer.future;
      }
    );
  }
}