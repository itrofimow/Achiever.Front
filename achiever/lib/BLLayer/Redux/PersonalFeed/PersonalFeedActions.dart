import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';
import 'package:achiever/AppContainer.dart';

import 'package:achiever/BLLayer/Models/Feed/FeedPageResponse.dart';

import 'dart:async';

abstract class BasePersonalFeedAction {
  bool isAchievementAction;
}

class AddPersonalFeedPageAction extends BasePersonalFeedAction {
  final FeedPageResponse page;
  final String authourId;

  AddPersonalFeedPageAction(this.page, this.authourId, bool isAchievementAction) {
    this.isAchievementAction = isAchievementAction;
  }
}

class ResetPersonalFeedAction extends BasePersonalFeedAction {
  final String authorId;

  ResetPersonalFeedAction(this.authorId, bool isAchievementAction) {
    this.isAchievementAction = isAchievementAction;
  }
}

class LockPersonalFeedAction extends BasePersonalFeedAction {
  final String authorId;

  LockPersonalFeedAction(this.authorId, bool isAchievementAction) {
    this.isAchievementAction = isAchievementAction;
  }
}

ThunkAction<AppState> fetchNewPersonalFeedPage(String authorId, Completer<Null> completer, bool isAchievementAction) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(LockPersonalFeedAction(authorId, isAchievementAction));
      
      final page = isAchievementAction
        ? await AppContainer.feedApi.getAchievementFeedPage(store.state.achievementsFeedState.feedByAuthor[authorId].lastIndex, authorId)
        : await AppContainer.feedApi.getAuthorFeedEntry(store.state.personalFeedState.feedByAuthor[authorId].lastIndex, authorId);

      store.dispatch(AddPersonalFeedPageAction(page, authorId, isAchievementAction));
    }
    finally {
      completer.complete();
    }
  };
}