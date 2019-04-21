import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Redux/PersonalFeed/PersonalFeedActions.dart';
import 'dart:async';

class PersonalFeedViewModel {
  final bool isAchievementViewModel;
  final String authorId;

  final List<FeedEntryResponse> entries;
  final Function resetFeed;
  final Function loadMore;

  bool isLocked;

  PersonalFeedViewModel({
    this.isAchievementViewModel,
    this.authorId,
    this.entries,
    this.resetFeed,
    this.loadMore,
    this.isLocked
  });

  static PersonalFeedViewModel fromStore(Store<AppState> store, String authorId, bool isAchievementViewModel) {
    final state = isAchievementViewModel ? store.state.achievementsFeedState : store.state.personalFeedState;

    return PersonalFeedViewModel(
      isAchievementViewModel: isAchievementViewModel,
      authorId: authorId,
      entries: state.feedByAuthor.containsKey(authorId)
        ? state.feedByAuthor[authorId].entries
        : [],
      resetFeed: () {
        store.dispatch(ResetPersonalFeedAction(authorId, isAchievementViewModel));
      },

      loadMore: () {
        final completer = Completer<Null>();
        store.dispatch(fetchNewPersonalFeedPage(authorId, completer, isAchievementViewModel));

        return completer.future;
      },

      isLocked: state.feedByAuthor.containsKey(authorId)
        ? state.feedByAuthor[authorId].isLocked
        : false
    );
  }
}