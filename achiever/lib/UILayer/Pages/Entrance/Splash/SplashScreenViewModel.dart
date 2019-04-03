import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';

class SplashScreenViewModel {
  final Function tryLoginAndRedirect;

  SplashScreenViewModel({
    this.tryLoginAndRedirect
  });

  static SplashScreenViewModel fromStore(Store<AppState> store) {
    return SplashScreenViewModel(
      tryLoginAndRedirect: () => store.dispatch(tryLoadCurrentUserAndRedirect)
    );
  }
}