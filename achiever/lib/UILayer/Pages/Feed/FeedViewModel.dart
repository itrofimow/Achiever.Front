import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Redux/Feed/FeedActions.dart';
import 'dart:async';

class FeedViewModel {
  final List<FeedEntryResponse> entries;
  final String userId;
  final Function getNew;
  final Function resetFeed;
  final String userProfileImage;

  final void Function(String) likeOrUnlikeCallback;

  FeedViewModel({
    this.entries,
    this.userId,
    this.getNew,
    this.resetFeed,
    this.likeOrUnlikeCallback,
    this.userProfileImage
  });

  static FeedViewModel fromStore(Store<AppState> store) {
    final state = store.state.feedState;

    return FeedViewModel(
      entries: state.entries.map((f) => state.allKnownEntries[f]).toList(),
      userId: store.state.userState.user.id,
      getNew: () {
        store.dispatch(fetchNewFeedPage);
      },
      resetFeed: () {
        store.dispatch(ResetFeedAction());

        final completer = Completer<Null>();
        store.dispatch(fetchNewFeedPage(completer));

        return completer.future;
      },
      likeOrUnlikeCallback: (String id) {
        //throw Exception('idk');
        store.dispatch(likeOrUnlike(id));
      },
      userProfileImage: store.state.userState.user.profileImagePath
    );
  }
} 