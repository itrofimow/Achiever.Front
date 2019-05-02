import 'package:achiever/BLLayer/ApiInterfaces/IFeedApi.dart';
import '../ApiClient.dart';

import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Models/Feed/CreateEntryByAchievementRequest.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryComment.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedPageResponse.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/User/AllUsersDto.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:quiver/strings.dart';

class FeedApi implements IFeedApi {
  static final FeedApi _instance = FeedApi._internal();
  ApiClient _client;

  factory FeedApi() {
    return _instance;
  }

  Future<FeedPageResponse> getMyFeedPage(int index, String startedAt) async {
    var url = '/feed/one/$index';

    final model = await _client.makeGet<FeedPageResponse>(
      url, 
      (json) => FeedPageResponse.fromJson(json),
      params: {"startedAt": isBlank(startedAt) ? '' : startedAt});

    return model;
  }

  Future<FeedPageResponse> getAuthorFeedEntry(int index, String authorId, String startedAt) async {
    var url = '/feed/authorone/$index/$authorId';

    final model = await _client.makeGet<FeedPageResponse>(
      url,
      (json) => FeedPageResponse.fromJson(json),
      params: {"startedAt": isBlank(startedAt) ? '' : startedAt});

    return model;
  }

  Future<FeedPageResponse> getAchievementFeedPage(int index, String achievementId, String startedAt) async {
    var url = '/feed/achievementOne/$index/$achievementId';

    final model = await _client.makeGet<FeedPageResponse>(
      url,
      (json) => FeedPageResponse.fromJson(json),
      params: {"startedAt": isBlank(startedAt) ? '' : startedAt});

    return model;
  }

  Future createFeedEntryByAchievement(CreateEntryByAchievementRequest request, List<File> images) async {
    final jData = request.toJson();
    jData['files'] = images.map((file) {
      return UploadFileInfo(file, basename(file.path));
    }).toList();

    final data = FormData.from(jData);

    await _client.postFormData('/feed', data);
  }

  Future likeOrUnlike(String feedEntryId) async {
    await _client.makePutNoModel('/feed/like/$feedEntryId');
  }

  Future<FeedEntryComment> addComment(String feedEntryId, FeedEntryComment comment) async {
    final response = await _client.makePutResponse<FeedEntryComment, FeedEntryComment>(
      '/feed/comment/$feedEntryId', comment,
      (json) => FeedEntryComment.fromJson(json));

    return response;
  }

  Future<List<UserDto>> getLikes(String feedEntryId) async {
    final response = await _client.makeGet<AllUsersDto>(
      '/feed/likes/$feedEntryId', 
      (json) => AllUsersDto.fromJson(json));

    return response.allUsers;
  }

  FeedApi._internal() {
    _client = new ApiClient();
  }
}