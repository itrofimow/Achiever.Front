import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntry.dart';

import 'FeedState.dart';
import 'FeedActions.dart';

final feedReducer = combineReducers<FeedState>([
  TypedReducer<FeedState, AddFeedPageAction>(_addPage),
  TypedReducer<FeedState, ResetFeedAction>(_resetFeed),
  TypedReducer<FeedState, LikeOrUnlikeAction>(_likeOrUnlike),
  TypedReducer<FeedState, AddCommentAction>(_addComment)
]);

FeedState _addPage(FeedState state, AddFeedPageAction action) {
  final entries = state.entries.map((f) => f).toList();
  entries.addAll(action.page.entries);

  return state.copyWith(
    lastIndex: state.lastIndex + 1, entries: entries,
    createdAt: action.page.startedAt);
}

FeedState _resetFeed(FeedState state, ResetFeedAction action) => FeedState.initial();

FeedState _likeOrUnlike(FeedState state, LikeOrUnlikeAction action) {
  final entries = state.entries.map((x){
    if (x.entry.id != action.id) return x;

    final newEntry = FeedEntry.copy(x.entry);
    newEntry.likesCount += x.isLiked ? -1 : 1;

    return FeedEntryResponse(x.authorProfileImagePath, x.authorNickname, newEntry, x.isLiked ^ true);
  }).toList();

  return state.copyWith(entries: entries);
}

FeedState _addComment(FeedState state, AddCommentAction action) {
  final entries = state.entries.map((f) => f).toList();

  final entry = entries.singleWhere((x) => x.entry.id ==action.feedEntryId);

  entry.entry.comments.add(action.comment);
  entry.entry.commentsCount++;

  return state.copyWith(entries: entries);
}