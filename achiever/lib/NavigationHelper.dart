import 'package:flutter/material.dart';
import 'AppContainer.dart';

import 'package:achiever/UILayer/Pages/Profile/MyProfile/MyProfilePage.dart';
import 'package:achiever/UILayer/Pages/Profile/TheirProfilePage.dart';

class NavigationHelper {
  static final Function(String, String, BuildContext) userNavigateFunc = 
  (String id, String nickname, BuildContext context) {
    if (id == AppContainer.store.state.userState.user.id) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MyProfilePage(),
        settings: RouteSettings(name: 'my profile')
      ));
    }
    else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => TheirProfilePage(id),
        settings: RouteSettings(name: nickname)
      ));
    }
  };
}