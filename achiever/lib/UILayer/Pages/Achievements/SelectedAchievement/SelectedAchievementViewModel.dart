import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';

class SelectedAchievementViewModel {
  final Achievement achievement;
  final AchievementCategory category;

  SelectedAchievementViewModel({
    this.achievement,
    this.category
  });

  static SelectedAchievementViewModel fromStore(Store<AppState> store, String achievementId) {
    final state = store.state.allAchievementsState;

    final achievement = state.achievements.singleWhere((x) => x.id == achievementId);
    final category = state.achievementCategories.singleWhere((x) => x.id == achievement.category.id);
    
    return SelectedAchievementViewModel(
      achievement: achievement,
      category: category
    );
  }
}