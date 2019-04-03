import '../Models/Feed/FeedEntryResponse.dart';
import '../Models/Feed/CreateEntryByAchievementRequest.dart';
import '../Models/Feed/FeedEntryComment.dart';
import '../Models/Feed/FeedPageResponse.dart';
import 'dart:io';

abstract class IFeedApi {
	Future<FeedPageResponse> getMyFeedPage(int index);

  Future<FeedEntryResponse> getAuthorFeedEntry(int index, String authorId);

  Future createFeedEntryByAchievement(CreateEntryByAchievementRequest request, List<File> images);

  Future likeOrUnlike(String feedEntryId);

  Future<FeedEntryComment> addComment(String feedEntryId, FeedEntryComment comment);
}