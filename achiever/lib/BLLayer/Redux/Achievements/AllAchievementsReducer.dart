import 'package:redux/redux.dart';
import 'AllAchievementsState.dart';
import 'AllAchievementsActions.dart';
import '../Models/AchievementsByCategory.dart';

final allAchievementsReducer = combineReducers<AllAchievementsState>([
  TypedReducer<AllAchievementsState, SetAchievementsList>(_updateList),
  TypedReducer<AllAchievementsState, StartLoadingList>(_setLoading),
  TypedReducer<AllAchievementsState, SetCategoriesList>(_setCategories),
  TypedReducer<AllAchievementsState, SetListByCategory>(_setListByCategory),
  TypedReducer<AllAchievementsState, GoToSearchPageAction>(_goToSearchPage),
  TypedReducer<AllAchievementsState, GoToCategoriesPageAction>(_goToCategoriesPage)
]);

AllAchievementsState _goToSearchPage(AllAchievementsState state, GoToSearchPageAction action) => 
  state.copyWith(inSearchPage: true);

AllAchievementsState _goToCategoriesPage(AllAchievementsState state, GoToCategoriesPageAction action) => 
  state.copyWith(inSearchPage: false);

AllAchievementsState _updateList(AllAchievementsState state, SetAchievementsList action) {
  final result = state.copyWith(achievements: action.achievements, isLoading: false);

  return result;
}

AllAchievementsState _setLoading(AllAchievementsState state, StartLoadingList action) =>
  state.copyWith(isLoading: true);

AllAchievementsState _setCategories(AllAchievementsState state, SetCategoriesList action) =>
  state.copyWith(achievementCategories: action.categories);

AllAchievementsState _setListByCategory(AllAchievementsState state, SetListByCategory action) {
  final map = Map<String, AchievementsByCategory>.from(state.achievementsByCategory);
  map[action.categoryId] = AchievementsByCategory(
    all: action.allAchievements, 
    my: action.myAchievements);

  return state.copyWith(
    achievementsByCategory: map
  );
}