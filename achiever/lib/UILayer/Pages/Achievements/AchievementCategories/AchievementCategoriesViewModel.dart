import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'package:achiever/BLLayer/Redux/Achievements/AllAchievementsActions.dart';
import 'dart:async';

class AchievementCategoriesViewModel {
  final List<AchievementCategory> achievementCategories;
  final String userProfileImagePath;
  final Function fetchAll;
  final bool inSearchPage;
  final Function goToSearch;
  final Function goToCategories;

  AchievementCategoriesViewModel({
    this.achievementCategories,
    this.userProfileImagePath,
    this.fetchAll,
    this.inSearchPage,
    this.goToSearch,
    this.goToCategories
  });

  static AchievementCategoriesViewModel fromStore(Store<AppState> store) {
    final state = store.state.allAchievementsState;

    return AchievementCategoriesViewModel(
      achievementCategories: state.achievementCategories,
      userProfileImagePath: store.state.userState.user.profileImagePath,
      fetchAll: () {
        final completer = Completer<Null>();

        store.dispatch(fetchAllCategoriesAction(completer));

        return completer.future;
      },
      inSearchPage: state.inSearchPage,
      goToSearch: () => store.dispatch(GoToSearchPageAction()),
      goToCategories: () => store.dispatch(GoToCategoriesPageAction())
    );
  }
}