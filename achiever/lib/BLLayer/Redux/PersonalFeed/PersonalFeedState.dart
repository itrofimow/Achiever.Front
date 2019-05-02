import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';

@immutable
class PersonalFeedState {
  final bool isAchievementState;
  final Map<String, PersonalFeed> feedByAuthor;

  PersonalFeedState({
    this.isAchievementState,
    this.feedByAuthor
  });

  PersonalFeedState copyWith({
    Map<String, PersonalFeed> feedByauthor
  }) {
    return PersonalFeedState(
      isAchievementState: this.isAchievementState,
      feedByAuthor: feedByauthor ?? this.feedByAuthor
    );
  }

  factory PersonalFeedState.initial(bool isAchievementState) {
    return PersonalFeedState(
      isAchievementState: isAchievementState,
      feedByAuthor: Map<String, PersonalFeed>()
    );
  }
}

class PersonalFeed {
  final List<FeedEntryResponse> entries;
  final int lastIndex;
  final String createdAt;
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
    String createdAt,
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
      createdAt: null,
      lastIndex: 0,
      entries: [],
      isLocked: false
    );
  }
}