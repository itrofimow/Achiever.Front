import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';
import 'package:achiever/AppContainer.dart';

import 'package:achiever/BLLayer/Models/Feed/FeedPageResponse.dart';

import 'dart:async';

class AddPersonalFeedPageAction {
  final FeedPageResponse page;
  final String authourId;

  AddPersonalFeedPageAction(this.page, this.authourId);
}

class ResetPersonalFeedAction {
  final String authorId;

  ResetPersonalFeedAction(this.authorId);  
}

class LockPersonalFeedAction {
  final String authorId;

  LockPersonalFeedAction(this.authorId);
}

ThunkAction<AppState> fetchNewPersonalFeedPage(String authorId, Completer<Null> completer) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(LockPersonalFeedAction(authorId));
      
      final page = await AppContainer.feedApi.getAuthorFeedEntry(
        store.state.personalFeedState.feedByAuthor[authorId].lastIndex, authorId);
      store.dispatch(AddPersonalFeedPageAction(page, authorId));
    }
    finally {
      completer.complete();
    }
  };
}