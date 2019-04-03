import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';

@immutable
class FeedState {
  final List<FeedEntryResponse> entries;
  final DateTime createdAt;
  final int lastIndex;

  FeedState({
    this.entries,
    this.createdAt,
    this.lastIndex,
  });

  FeedState copyWith({
    List<FeedEntryResponse> entries,
    DateTime createdAt,
    int lastIndex,
    String selectedEntryId
  }) {
    return FeedState(
      entries: entries ?? this.entries,
      createdAt: createdAt ?? this.createdAt,
      lastIndex: lastIndex ?? this.lastIndex,
    );
  }

  factory FeedState.initial() {
    return FeedState(
      entries: List<FeedEntryResponse>(),
      createdAt: DateTime.now(),
      lastIndex: 0,
    );
  }
}