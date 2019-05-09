import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:achiever/BLLayer/Redux/AppState.dart';

import 'package:achiever/UILayer/UIKit/Buttons/AchieverSecondaryButton.dart';
import 'package:achiever/UILayer/UXKit/KeepAliveFutureBuilder.dart';
import 'package:achiever/UILayer/Pages/Feed/FeedTile.dart';
import 'EditProfilePage.dart';

import 'package:achiever/UILayer/UIKit/AchieverNavigationBar.dart';

import 'MyProfileViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';

import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'package:quiver/strings.dart';

import 'package:achiever/UILayer/UIKit/ScrollWithoutGlow.dart';
import 'SettingsPage.dart';

import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';

import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import '../ExtendedStatsPage.dart';

import '../../PersonalFeed/PersonalFeedPage.dart';
import 'dart:async';

import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';

import '../ProfileBuilder.dart';

class MyProfilePage extends StatefulWidget {

  @override
  State createState() => new MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  ScrollController _scrollController = ScrollController();

  bool loadingEntriesCount = true;
  int entriesCount = 0;

  Future fetchEntriesCount(String userId) async {
    final count = await AppContainer.userApi.countFeedEntries(userId);

    setState(() {
      loadingEntriesCount = false;
      entriesCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MyProfileViewModel>(
      onInit: (store) {
        final initViewModel = MyProfileViewModel.fromStore(store);
        fetchEntriesCount(initViewModel.user.id);
        AppContainer.store.dispatch(AddManyKnownUsersAction(initViewModel.followers));
        AppContainer.store.dispatch(AddManyKnownUsersAction(initViewModel.followings));
      },
      converter: (store) => MyProfileViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel)
    );
  }

  Widget _buildLayout(BuildContext context, MyProfileViewModel viewModel) {
    return ScrollWithoutGlow(
      child: RefreshIndicator(
        onRefresh: () {
          fetchEntriesCount(viewModel.user.id);
          return viewModel.resetPersonalFeed();
        },
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            _buildFitted(context, _buildHeader(context, viewModel.user)),
            _buildFitted(context, _buildAbout(context, viewModel)),
            _buildFitted(context, _buildStats(context, viewModel)),
            ProfileBuilder.buildDivider(context),
            _buildPersonalFeed(context, viewModel)
          ],
        )
      )
    );
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }

  Widget _buildHeader(BuildContext context, User user) {
    final profileImage = new Container(
      height: 56.0,
      width: 56.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${user.profileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profileImage,
          Expanded(child: Container(),),
          _buildHeaderButtons(context, user)
        ],
      ),
    );
  }

  static Widget _buildHeaderButtons(BuildContext context, User user) {
    final editButton = GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Color.fromARGB(255, 242, 242, 242)
          ),
          height: 36,
          child: Center(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text('Редактировать', style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.22,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 51, 51, 51)
              )),
            ),
          ),
        ),
      ),
      onTap: () => Keys.baseNavigatorKey.currentState.push(MaterialPageRoute(
          builder: (_) => EditProfilePage(user), settings: RouteSettings(
            name: 'editProfile'
          ))),
    );

    final settingsButton = GestureDetector(
      child: Container(
        height: 36,
        width: 36,
        child: Image.asset('assets/settings_icon.png', width: 36, height: 36),
      ),
      onTap: () => Keys.baseNavigatorKey.currentState.push(MaterialPageRoute(
        builder: (_) => SettingsPage()
      )),
    );

    return Row(
      children: <Widget>[
        editButton,
        settingsButton
      ],
    );

    /*return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 8),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Color.fromARGB(255, 242, 242, 242)
            ),
            height: 36,
            child: Center(
              widthFactor: 1,
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text('Вы подписаны', style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 51, 51, 51)
                )),
              ),
            ),
          ),
        ),
        onTap: () => Keys.baseNavigatorKey.currentState.push(MaterialPageRoute(
            builder: (_) => EditProfilePage(user), settings: RouteSettings(
              name: 'editProfile'
            ))),
    );*/
  }

  Widget _buildAbout(BuildContext context, MyProfileViewModel viewModel) {
    return ProfileBuilder.buildAbout(context, viewModel.user);
  }

  Widget _buildStats(BuildContext context, MyProfileViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileBuilder.buildStatsBlock(context, loadingEntriesCount ? 0 : entriesCount, 'Записей'),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: ProfileBuilder.buildStatsBlock(context, viewModel.user.stats.followers, 'Подписчиков'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (innerContext) => ExtendedStatsPage(Future.value(viewModel.followers)),
                settings: RouteSettings(name: 'followers')
              )),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: ProfileBuilder.buildStatsBlock(context, viewModel.user.stats.following, 'Подписок'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ExtendedStatsPage(Future.value(viewModel.followings)),
                settings: RouteSettings(name: 'followings')
              )),
            )
          )
        ]
      ),
    );
  }

  Widget _buildPersonalFeed(BuildContext context, MyProfileViewModel viewModel) {
    return PersonalFeedPage(false, viewModel.user.id, _scrollController);
  }
}