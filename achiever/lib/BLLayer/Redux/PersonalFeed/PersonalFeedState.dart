import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';

@immutable
class PersonalFeedState {
  final Map<String, PersonalFeed> feedByAuthor;

  PersonalFeedState({
    this.feedByAuthor
  });

  PersonalFeedState copyWith({
    Map<String, PersonalFeed> feedByauthor
  }) {
    return PersonalFeedState(
      feedByAuthor: feedByauthor ?? this.feedByAuthor
    );
  }

  factory PersonalFeedState.initial() {
    return PersonalFeedState(
      feedByAuthor: Map<String, PersonalFeed>()
    );
  }
}

class PersonalFeed {
  final List<FeedEntryResponse> entries;
  final int lastIndex;
  final DateTime createdAt;
  bool isLocked;

  PersonalFeed({
    this.entries,
    this.lastIndex,
    this.createdAt,
    this.isLocked
  });

  PersonalFeed copyWith({
    List<FeedEntryResponse> entries,
    int lastIndex,
    DateTime createdAt,
    bool isLocked
  }) {
    return PersonalFeed(
      entries: entries ?? this.entries,
      lastIndex: lastIndex ?? this.lastIndex,
      createdAt: createdAt ?? this.createdAt,
      isLocked: isLocked ?? this.isLocked
    );
  }

  factory PersonalFeed.initial() {
    return PersonalFeed(
      createdAt: DateTime.now(),
      lastIndex: 0,
      entries: [],
      isLocked: false
    );
  }
}