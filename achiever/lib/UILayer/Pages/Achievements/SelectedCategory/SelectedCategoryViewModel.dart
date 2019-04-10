import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Redux/Achievements/AllAchievementsActions.dart';
import 'package:achiever/BLLayer/Redux/Models/AchievementsByCategory.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'dart:async';

class SelectedCategoryViewModel {
  final String categoryId;
  final AchievementCategory category;
  final List<Achievement> allAchievements;
  final List<Achievement> myAchievements;
  final String name;

  final Function fetchByCategoryFunc;

  SelectedCategoryViewModel({
    this.categoryId,
    this.category,
    this.allAchievements,
    this.myAchievements,
    this.name,
    this.fetchByCategoryFunc
  });
  
  static SelectedCategoryViewModel fromStore(Store<AppState> store, String categoryId) {
    final state = store.state.allAchievementsState;

    final achievementsByCategory = state.achievementsByCategory[categoryId] ?? 
      AchievementsByCategory(all: List<Achievement>(0), my: List<Achievement>());

    return SelectedCategoryViewModel(
      categoryId: categoryId,
      category: state.achievementCategories.singleWhere((x) => x.id == categoryId),
      allAchievements: achievementsByCategory.all,
      myAchievements: achievementsByCategory.my,
      name: state.achievementCategories.singleWhere((x) => x.id == categoryId).title,
      fetchByCategoryFunc: () {
        final completer = Completer<Null>();
        store.dispatch(fetchByCategory(categoryId, completer));

        return completer.future;
      }
    );
  }
}