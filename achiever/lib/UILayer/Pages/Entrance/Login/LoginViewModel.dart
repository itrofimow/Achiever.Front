import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/Models/LoadingStatus.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Redux/Login/LoginActions.dart';

class LoginViewModel {
  final LoadingStatus loadingStatus;

  final String nickname;
  final String password;

  final String error;

  final Function login;

  final Function(String nickname) updateNickname;
  final Function(String password) updatePassword;

  LoginViewModel({
    this.loadingStatus,
    this.nickname,
    this.password,
    this.error,
    this.login,
    this.updateNickname,
    this.updatePassword
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    final state = store.state.loginState;
    
    return LoginViewModel(
      loadingStatus: state.loadingStatus,
      nickname: state.nickname,
      password: state.password,
      error: state.error,
      login: () {
        store.dispatch(UpdateLoadingStatusAction(LoadingStatus.loading));
        store.dispatch(validateLoginAction);
      },
      updateNickname: (nickname) {
        store.dispatch(UpdateNicknameAction(nickname));
      },
      updatePassword: (password) {
        store.dispatch(UpdatePasswordAction(password));
      }
    );
  }
}