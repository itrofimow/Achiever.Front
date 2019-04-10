import 'package:achiever/BLLayer/ApiInterfaces/IUserApi.dart';
import '../ApiClient.dart';

import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/BLLayer/Models/User/FeedEntriesCount.dart';
import 'package:achiever/BLLayer/Models/Notifications/AchieverNotification.dart';
import 'package:achiever/BLLayer/Models/Notifications/NotificationsList.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class UserApi implements IUserApi {
  static final UserApi _instance = UserApi._internal();
  ApiClient _client;

  factory UserApi() {
    return _instance;
  }

  Future<User> getCurrentUser() async {
    final model = await _client.makeGet<User>(
      '/user/current', 
      (json) => User.fromJson(json));

    return model;
  }

  Future<User> getById(String id) async {
    final model = await _client.makeGet<User>(
      '/user/$id', 
      (json) => User.fromJson(json));

    return model;
  }

  Future<User> update(User model, File image) async {
    final Map<String, dynamic> jData = model.toJson();
    if (image != null)
      jData['image'] = UploadFileInfo(image, 'we');

    final data = FormData.from(jData);

    final response = await _client.postFormDataResponse<User>('/user/current', data,
      (json) => User.fromJson(json));

    return response;
  }

  Future<List<AchieverNotification>> getNotifications() async {
    final model = await _client.makeGet<NotificationsList>(
      '/user/current/notifications', 
      (json) => NotificationsList.fromJson(json));

    return model.notifications;
  }

  Future<int> countFeedEntries(String userId) async {
    final model = await _client.makeGet<FeedEntriesCount>(
      '/user/countEntries/$userId',
      (json) => FeedEntriesCount.fromJson(json));

    return model.count;
  }

  UserApi._internal() {
    _client = new ApiClient();
  }
}