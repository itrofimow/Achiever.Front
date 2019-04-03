import 'package:meta/meta.dart';

@immutable
class DraftState {
  final String newNickname;
  final String newAbout;
  final String newProfileImagePath;

  DraftState({
    this.newNickname,
    this.newAbout,
    this.newProfileImagePath
  });

  DraftState copyWith({
    String newNickname,
    String newAbout,
    String newProfileImagePath
  }) {
    return DraftState(
      newNickname: newNickname ?? this.newNickname,
      newAbout: newAbout ?? this.newAbout,
      newProfileImagePath: newProfileImagePath ?? this.newProfileImagePath
    );
  }

  factory DraftState.initial() {
    return DraftState(
      newNickname: null,
      newAbout: null,
      newProfileImagePath: null
    );
  }
}