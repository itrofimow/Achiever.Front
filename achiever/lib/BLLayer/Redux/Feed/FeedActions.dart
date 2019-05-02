import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';
import 'package:achiever/AppContainer.dart';

import 'package:achiever/BLLayer/Models/Feed/FeedEntryComment.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedPageResponse.dart';

import 'dart:async';

class AddFeedPageAction {
  final FeedPageResponse page;

  AddFeedPageAction(this.page);
}

class ResetFeedAction {}

class LikeOrUnlikeAction {
  final String id;

  LikeOrUnlikeAction(this.id);
}

class AddCommentAction {
  final String feedEntryId;
  final FeedEntryComment comment;

  AddCommentAction(this.feedEntryId, this.comment);
}

ThunkAction<AppState> likeOrUnlike(String id) {
  return (Store<AppState> store) async { 
    store.dispatch(LikeOrUnlikeAction(id));
    try {
      await AppContainer.feedApi.likeOrUnlike(id);
    }
    catch (e) {
      await Future.delayed(Duration(seconds: 5));
      store.dispatch(LikeOrUnlikeAction(id));
    }
  };
}

ThunkAction<AppState> fetchNewFeedPage(Completer<Null> completer) {
  return (Store<AppState> store) async {
    try {
      final entry = await AppContainer.feedApi.getMyFeedPage(store.state.feedState.lastIndex, store.state.feedState.createdAt);
      store.dispatch(AddFeedPageAction(entry));
    }
    finally {
      completer.complete();
    }
  };
}

ThunkAction<AppState> addComment(String feedEntryId, String text) {
  return (Store<AppState> store) async {
    final comment = FeedEntryComment('', text, '', '');

    final response = await AppContainer.feedApi.addComment(feedEntryId, comment);

    store.dispatch(AddCommentAction(feedEntryId, response));
  };
}