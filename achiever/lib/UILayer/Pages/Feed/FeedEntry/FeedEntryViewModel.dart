import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/BLLayer/Redux/Feed/FeedActions.dart';

class FeedEntryViewModel {
  final FeedEntryResponse model;
  final Function likeOrUnlikeCallback;
  final Function(String) addCommentFunc;

  FeedEntryViewModel({
    this.model,
    this.likeOrUnlikeCallback,
    this.addCommentFunc
  });

  static FeedEntryViewModel fromStore(Store<AppState> store, String id) {
    final state = store.state.feedState;

    final entry = state.allKnownEntries[id];

    return FeedEntryViewModel(
      model: entry,
      likeOrUnlikeCallback: () {
        store.dispatch(likeOrUnlike(entry.entry.id));
      },
      addCommentFunc: (String text) {
        store.dispatch(addComment(entry.entry.id, text));
      }
    );
  }
}