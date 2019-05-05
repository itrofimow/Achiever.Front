import 'package:meta/meta.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';

@immutable
class FeedState {
  final Map<String, FeedEntryResponse> allKnownEntries;

  final List<String> entries;
  final String createdAt;
  final int lastIndex;

  FeedState({
    this.allKnownEntries,
    this.entries,
    this.createdAt,
    this.lastIndex,
  });

  FeedState copyWith({
    Map<String, FeedEntryResponse> allKnownEntries,
    List<String> entries,
    String createdAt,
    int lastIndex,
    String selectedEntryId
  }) {
    return FeedState(
      allKnownEntries: allKnownEntries ?? this.allKnownEntries,
      entries: entries ?? this.entries,
      createdAt: createdAt ?? this.createdAt,
      lastIndex: lastIndex ?? this.lastIndex,
    );
  }

  factory FeedState.initial() {
    return FeedState(
      allKnownEntries: Map<String, FeedEntryResponse>(),
      entries: List<String>(),
      createdAt: null,
      lastIndex: 0,
    );
  }
}