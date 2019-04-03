import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';

import 'dart:async';

ThunkAction<AppState> fetchAllAchievementsAction(Completer<Null> completer) {
  return (Store<AppState> store) async {
    store.dispatch(StartLoadingList());

    final allAchievements = await AppContainer.achievementApi.getAll();

    store.dispatch(SetAchievementsList(allAchievements));
    completer.complete();
  };
}

class SetAchievementsList {
  final List<Achievement> achievements;

  SetAchievementsList(this.achievements);
}

class StartLoadingList {}

ThunkAction<AppState> fetchByCategory(String categoryId, Completer<Null> completer) {
  return (Store<AppState> store) async {
    final result = await Future.wait(
      [
        AppContainer.achievementApi.getByCategory(categoryId),
        AppContainer.achievementApi.getMyByCategory(categoryId)
      ]);

    store.dispatch(SetListByCategory(categoryId, result[0], result[1]));
    completer.complete();
  };
}

class SetListByCategory {
  final String categoryId;
  final List<Achievement> allAchievements;
  final List<Achievement> myAchievements;

  SetListByCategory(
    this.categoryId, 
    this.allAchievements, 
    this.myAchievements);
}

ThunkAction<AppState> fetchAllCategoriesAction(Completer<Null> completer) {
  return (Store<AppState> store) async {
    try {
      final categories = await AppContainer.achievementApi.getAllCategories();
      store.dispatch(SetCategoriesList(categories));
    }
    finally {
      completer.complete();
    }
  };
}

class SetCategoriesList {
  final List<AchievementCategory> categories;

  SetCategoriesList(this.categories);
}

class GoToSearchPageAction {}

class GoToCategoriesPageAction {}