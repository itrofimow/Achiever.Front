import '../Models/Achievement/Achievement.dart';
import '../Models/AchievementCategories/AchievementCategory.dart';
import 'dart:io';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';

abstract class IAchievementApi {
	Future<List<Achievement>> getAll();

  Future<List<Achievement>> getByCategory(String categoryId);

  Future<List<Achievement>> getMyByCategory(String categoryId);

  Future<Achievement> getById(String id);

  Future<List<UserDto>> getFollowingsWhoHave(String achievementId);

  Future createAchievement(Achievement model, File backgroundImage, File foregroundImage);

  Future<List<AchievementCategory>> getAllCategories();
}