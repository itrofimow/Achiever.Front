import '../Models/Feed/FeedEntryResponse.dart';
import '../Models/Feed/CreateEntryByAchievementRequest.dart';
import '../Models/Feed/FeedEntryComment.dart';
import '../Models/Feed/FeedPageResponse.dart';
import '../Models/User/UserDto.dart';
import 'dart:io';

abstract class IFeedApi {
	Future<FeedPageResponse> getMyFeedPage(int index, String startedAt);

  Future<FeedPageResponse> getAuthorFeedEntry(int index, String authorId, String startedAt);

  Future<FeedPageResponse> getAchievementFeedPage(int index, String achievementId, String startedAt);

  Future createFeedEntryByAchievement(CreateEntryByAchievementRequest request, List<File> images);

  Future likeOrUnlike(String feedEntryId);

  Future<FeedEntryComment> addComment(String feedEntryId, FeedEntryComment comment);

  //Future<List<UserDto>> getLikes(String feedEntryId);
}