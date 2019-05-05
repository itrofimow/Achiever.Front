import 'dart:io';
import 'package:path/path.dart';

import 'package:achiever/BLLayer/ApiInterfaces/IAchievementApi.dart';
import '../ApiClient.dart';

import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Models/Achievement/AllAchievementsResponse.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategoriesResponse.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/User/AllUsersDto.dart';
import 'package:achiever/BLLayer/Models/Achievement/AcquiredAtDto.dart';

import 'package:dio/dio.dart';

class AchievementApi implements IAchievementApi {
  static final AchievementApi _instance = AchievementApi._internal();
  ApiClient _client;

  factory AchievementApi() {
    return _instance;
  }

  Future<List<Achievement>> getAll() async {
    //await Future.delayed(Duration(milliseconds: 4000));
    final model = await _client.makeGet<AllAchievementsResponse>(
      '/achievement/all', 
      (json) => AllAchievementsResponse.fromJson(json));

    return model.achievements;
  }

  Future<List<Achievement>> getByCategory(String categoryId) async {
    final data = await _client.makeGet<AllAchievementsResponse>(
      '/achievement/categories/$categoryId', 
      (json) => AllAchievementsResponse.fromJson(json));

    return data.achievements;
  }

  Future<List<Achievement>> getMyByCategory(String categoryId) async {
    final data = await _client.makeGet<AllAchievementsResponse>(
      '/acquiredAchievement/my/category/$categoryId', 
      (json) => AllAchievementsResponse.fromJson(json));

    return data.achievements;
  }

  Future<Achievement> getById(String id) async {
    final model = await _client.makeGet<Achievement>(
      '/achievement/id/$id', 
      (json) => Achievement.fromJson(json));

    return model;
  }

  Future<List<UserDto>> getFollowingsWhoHave(String achievementId) async {
    final data = await _client.makeGet<AllUsersDto>(
      '/acquiredAchievement/my/followings/$achievementId',
      (json) => AllUsersDto.fromJson(json)
    );

    return data.allUsers;
  }

  Future createAchievement(Achievement model) async {
    final data = FormData.from({
      'title': model.title,
      'description': model.description,
      'categoryId': model.category.id,

      'backgroundImage': model.backgroundImage.imagePath == null 
        ? null
        : UploadFileInfo(File(model.backgroundImage.imagePath), 'we'),
      'frontImage': model.frontImage.imagePath == null 
        ? null
        : UploadFileInfo(File(model.frontImage.imagePath), 'we'),
      'bigImage': model.bigImage.imagePath == null
        ? null
        : UploadFileInfo(File(model.bigImage.imagePath), 'we')
    });

    await _client.postFormData('/achievement', data);
  }

  Future<List<AchievementCategory>> getAllCategories() async {
    final response = await _client.makeGet<AchievementCategoriesResponse>(
      '/achievement/categories', 
      (json) => AchievementCategoriesResponse.fromJson(json));

    return response.categories;
  }

  Future<AcquiredAtDto> checkIHave(String achievementId) async {
    final response = await _client.makeGet<AcquiredAtDto>(
      '/acquiredAchievement/my/check/$achievementId',
      (json) => AcquiredAtDto.fromJson(json)
    );

    return response;
  }

  AchievementApi._internal() {
    _client = new ApiClient();
  }
}