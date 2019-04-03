import 'package:meta/meta.dart';
import '../Models/LoadingStatus.dart';

@immutable
class LoginState {
  final LoadingStatus loadingStatus;
  
  final String nickname;
  final String password;

  final String error;


  LoginState({
    this.loadingStatus,
    this.nickname,
    this.password,
    this.error
  });

  LoginState copyWith({
    LoadingStatus loadingStatus,
    String nickname,
    String password,
    String error
  }) {
    return LoginState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      error: error ?? this.error
    );
  }

  factory LoginState.initial() {
    return LoginState(
      loadingStatus: LoadingStatus.success,
      nickname: '',
      password: '',
      error: ''
    );
  }
}