import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import '../PersonalFeed/PersonalFeedActions.dart';

import 'FeedState.dart';
import 'FeedActions.dart';

final feedReducer = combineReducers<FeedState>([
  TypedReducer<FeedState, AddFeedPageAction>(_addPage),
  TypedReducer<FeedState, ResetFeedAction>(_resetFeed),
  TypedReducer<FeedState, LikeOrUnlikeAction>(_likeOrUnlike),
  TypedReducer<FeedState, AddCommentAction>(_addComment),
  TypedReducer<FeedState, AddPersonalFeedPageAction>(_processPersonalFeedPage)
]);

FeedState _addPage(FeedState state, AddFeedPageAction action) {
  final entries = List<String>.from(state.entries);
  final allKnownEntries = Map<String, FeedEntryResponse>.from(state.allKnownEntries);

  entries.addAll(action.page.entries.map((f) => f.entry.id));
  action.page.entries.forEach((f) => allKnownEntries[f.entry.id] = f);

  return state.copyWith(
    lastIndex: state.lastIndex + 1, 
    allKnownEntries: allKnownEntries, entries: entries,
    createdAt: action.page.startedAt);
}

FeedState _processPersonalFeedPage(FeedState state, AddPersonalFeedPageAction action) {
  final allKnownEntries = Map<String, FeedEntryResponse>.from(state.allKnownEntries);

  action.page.entries.forEach((f) => allKnownEntries[f.entry.id] = f);

  return state.copyWith(allKnownEntries: allKnownEntries);
}

FeedState _resetFeed(FeedState state, ResetFeedAction action) {
  final newState = FeedState.initial();

  return newState.copyWith(allKnownEntries: state.allKnownEntries);
}

FeedState _likeOrUnlike(FeedState state, LikeOrUnlikeAction action) {
  final allKnownEntries = Map<String, FeedEntryResponse>.from(state.allKnownEntries);
  
  final entry = allKnownEntries[action.id];
  entry.entry.likesCount += entry.isLiked ? -1 : 1;

  allKnownEntries[action.id] = FeedEntryResponse(entry.authorProfileImagePath, entry.authorNickname, entry.entry, entry.isLiked ^ true);

  return state.copyWith(allKnownEntries: allKnownEntries);
}

FeedState _addComment(FeedState state, AddCommentAction action) {
  final entry = state.allKnownEntries[action.feedEntryId];

  entry.entry.comments.add(action.comment);
  entry.entry.commentsCount++;

  final allKnownEntries = Map<String, FeedEntryResponse>.from(state.allKnownEntries);
  allKnownEntries[action.feedEntryId] = entry;

  return state.copyWith(allKnownEntries: allKnownEntries);
}