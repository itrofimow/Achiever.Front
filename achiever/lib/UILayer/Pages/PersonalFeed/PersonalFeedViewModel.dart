import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Redux/PersonalFeed/PersonalFeedActions.dart';
import 'dart:async';

class PersonalFeedViewModel {
  final String authorId;

  final List<FeedEntryResponse> entries;
  final Function resetFeed;
  final Function loadMore;

  bool isLocked;

  PersonalFeedViewModel({
    this.authorId,
    this.entries,
    this.resetFeed,
    this.loadMore,
    this.isLocked
  });

  static PersonalFeedViewModel fromStore(Store<AppState> store, String authorId) {
    final state = store.state.personalFeedState;

    return PersonalFeedViewModel(
      authorId: authorId,
      entries: state.feedByAuthor.containsKey(authorId)
        ? state.feedByAuthor[authorId].entries
        : [],
      resetFeed: () {
        store.dispatch(ResetPersonalFeedAction(authorId));
      },

      loadMore: () {
        final completer = Completer<Null>();
        store.dispatch(fetchNewPersonalFeedPage(authorId, completer));

        return completer.future;
      },

      isLocked: state.feedByAuthor.containsKey(authorId)
        ? state.feedByAuthor[authorId].isLocked
        : false
    );
  }
}