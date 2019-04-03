import 'package:redux/redux.dart';

import 'LoginState.dart';
import 'LoginActions.dart';
import '../Models/LoadingStatus.dart';

final loginReducer = combineReducers<LoginState>([
  TypedReducer<LoginState, ClearErrorsAction>(_clearErrors),
  TypedReducer<LoginState, UpdateNicknameAction>(_updateNickname),
  TypedReducer<LoginState, UpdatePasswordAction>(_updatePassword),
  TypedReducer<LoginState, UpdateLoadingStatusAction>(_updateLoadingStatus)
]);

LoginState _clearErrors(LoginState state, ClearErrorsAction action) =>
  state.copyWith(loadingStatus: LoadingStatus.success, error: '');
  
LoginState _updateNickname(LoginState state, UpdateNicknameAction action) =>
  state.copyWith(nickname: action.nickname);

LoginState _updatePassword(LoginState state, UpdatePasswordAction action) =>
  state.copyWith(password: action.password);

LoginState _updateLoadingStatus(LoginState state, UpdateLoadingStatusAction action) => 
  state.copyWith(loadingStatus: action.status);