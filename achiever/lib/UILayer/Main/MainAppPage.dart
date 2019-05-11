import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'MainAppViewModel.dart';
import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';
import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'MainPageNavigatorObserver.dart';

import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';

class MainAppPage extends StatelessWidget {

  MainAppPage() : super(key : UniqueKey());

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainAppViewModel> (
      onInit: (store) {
        store.dispatch(fetchFollowers);
        store.dispatch(fetchFollowings);
      },
      converter: (store) => MainAppViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, MainAppViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async => 
        await viewModel.processBackNavigation(),
      child: Scaffold(
        appBar: viewModel.buildAppBar(),
        body: _buildStackWithOffstages(context, viewModel),
        bottomNavigationBar: AchieverNavigationBar(
          currentIndex: viewModel.currentNavigationIndex,
          profileImagePath: viewModel.userProfileImage,
          onTap: (index) => viewModel.processTap(index)
        ),
      )
    );
  }

  Widget _buildStackWithOffstages(BuildContext context, MainAppViewModel viewModel) {
    return Stack(
      children: <Widget>[
        _buildOffstageNavigator(context, viewModel, 'feed', 0),
        _buildOffstageNavigator(context, viewModel, 'search', 1),
        _buildOffstageNavigator(context, viewModel, 'add', 2),
        _buildOffstageNavigator(context, viewModel, 'notifications', 3),
        _buildOffstageNavigator(context, viewModel, 'profile', 4),
      ],
    );
  }

  Widget _buildOffstageNavigator(BuildContext context, MainAppViewModel viewModel, String route, int index) {
    return Offstage(
      offstage: index != viewModel.currentNavigationIndex,
      child: Navigator(
        key: Keys.mainPageNavigators[index],
        observers: [MainPageNavigatorObserver(index, AppContainer.store)],
        initialRoute: route,
        onGenerateRoute: (settings) {
          return NoOpacityMaterialPageRoute(
            builder: mainAppRoutes[settings.name],
            settings: RouteSettings(name: settings.name),
            //maintainState: 
          );
        },
      ),
    );
  }
}




