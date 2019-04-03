import 'dart:async';
import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import '../Models/AchievementsByCategory.dart';

@immutable
class AllAchievementsState {
  final List<Achievement> achievements;
  final List<AchievementCategory> achievementCategories;
  final Map<String, AchievementsByCategory> achievementsByCategory;
  final bool inSearchPage;
  final bool isLoading;

  AllAchievementsState({
    this.achievements,
    this.achievementCategories,
    this.achievementsByCategory,
    this.inSearchPage,
    this.isLoading
  });

  AllAchievementsState copyWith({
    List<Achievement> achievements,
    List<AchievementCategory> achievementCategories,
    Map<String, AchievementsByCategory> achievementsByCategory,
    bool inSearchPage,
    bool isLoading
  }) {
    return AllAchievementsState(
      achievements: achievements ?? this.achievements,
      achievementCategories: achievementCategories ?? this.achievementCategories,
      achievementsByCategory: achievementsByCategory ?? this.achievementsByCategory,
      inSearchPage: inSearchPage ?? this.inSearchPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  factory AllAchievementsState.initial() {
    return AllAchievementsState(
      achievements: List<Achievement>(),
      achievementCategories: List<AchievementCategory>(),
      achievementsByCategory: Map<String, AchievementsByCategory>(),
      inSearchPage: false,
      isLoading: false,
    );
  }
}