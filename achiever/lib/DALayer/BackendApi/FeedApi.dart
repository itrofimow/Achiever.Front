import 'package:achiever/BLLayer/ApiInterfaces/IFeedApi.dart';
import '../ApiClient.dart';

import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Models/Feed/CreateEntryByAchievementRequest.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryComment.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedPageResponse.dart';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class FeedApi implements IFeedApi {
  static final FeedApi _instance = FeedApi._internal();
  ApiClient _client;

  factory FeedApi() {
    return _instance;
  }

  Future<FeedPageResponse> getMyFeedPage(int index) async {
    final model = await _client.makeGet<FeedPageResponse>(
      '/feed/one/$index', 
      (json) => FeedPageResponse.fromJson(json));

    return model;
  }

  Future<FeedPageResponse> getAuthorFeedEntry(int index, String authorId) async {
    final model = await _client.makeGet<FeedPageResponse>(
      '/feed/authorone/$index/$authorId',
      (json) => FeedPageResponse.fromJson(json));

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

  FeedApi._internal() {
    _client = new ApiClient();
  }
}