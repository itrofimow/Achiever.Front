import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'SplashScreenViewModel.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';

class SplashScreenPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashScreenViewModel> (
      onInit: (store) {
        store.dispatch(tryLoadCurrentUserAndRedirect);
      },
      converter: (store) => SplashScreenViewModel.fromStore(store),
      builder: (context, _) => _buildLayout(context),
    );
  }

  Widget _buildLayout(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}