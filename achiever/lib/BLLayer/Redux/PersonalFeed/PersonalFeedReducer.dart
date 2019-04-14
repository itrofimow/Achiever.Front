import 'package:redux/redux.dart';

import 'PersonalFeedState.dart';
import 'PersonalFeedActions.dart';

final personalFeedReducer = combineReducers<PersonalFeedState>([
  TypedReducer<PersonalFeedState, AddPersonalFeedPageAction>(_addPersonalFeedPage),
  TypedReducer<PersonalFeedState, ResetPersonalFeedAction>(_resetPersonalFeed),
  TypedReducer<PersonalFeedState, LockPersonalFeedAction>(_lockPersonalFeed)
]);

PersonalFeedState _addPersonalFeedPage(PersonalFeedState state, AddPersonalFeedPageAction action) {
  final oldFeed = state.feedByAuthor[action.authourId];

  final newList = oldFeed.entries;
  newList.addAll(action.page.entries);

  final newFeed = PersonalFeed(
    lastIndex: oldFeed.lastIndex + 1,
    entries: newList,
    createdAt: oldFeed.createdAt,
    isLocked: false
  );

  final newMap = Map<String, PersonalFeed>.from(state.feedByAuthor);
  newMap[action.authourId] = newFeed;

  return state.copyWith(feedByauthor: newMap);
}

PersonalFeedState _resetPersonalFeed(PersonalFeedState state, ResetPersonalFeedAction action) {
  final newMap = Map<String, PersonalFeed>.from(state.feedByAuthor);
  newMap[action.authorId] = PersonalFeed.initial();

  return state.copyWith(feedByauthor: newMap);
}

PersonalFeedState _lockPersonalFeed(PersonalFeedState state, LockPersonalFeedAction action) {
  final newMap = Map<String, PersonalFeed>.from(state.feedByAuthor);
  newMap[action.authorId].isLocked = true;

  return state.copyWith(feedByauthor: newMap);
}