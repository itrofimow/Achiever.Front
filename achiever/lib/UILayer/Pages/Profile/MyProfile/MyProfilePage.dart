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

class MyProfilePage extends StatefulWidget {

  @override
  State createState() => new MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MyProfileViewModel>(
      converter: (store) => MyProfileViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel)
    );
  }

  Widget _buildLayout(BuildContext context, MyProfileViewModel viewModel) {
    final appBar = AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('Мой профиль', style: TextStyle(
        fontSize: 21,
        letterSpacing: 0.34,
        color: Color.fromARGB(255, 51, 51, 51),
        fontWeight: FontWeight.w700
      ),),
      elevation: 0,
      leading: Container(),
    );

    return Scaffold(
      appBar: appBar,
      body: ScrollWithoutGlow(
        child: ListView(
          children: <Widget>[
            _buildFitted(context, _buildHeader(context, viewModel)),
            _buildFitted(context, _buildAbout(context, viewModel)),
            _buildFitted(context, _buildStats(context, viewModel)),
            _buildDivider(context)
          ],
        )
      ),
      bottomNavigationBar: AchieverNavigationBar(
        currentIndex: 4,
        profileImagePath: viewModel.user.profileImagePath,
        onTap: (index) => {},
      ),
    );
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }

  Widget _buildHeader(BuildContext context, MyProfileViewModel viewModel) {
    final profileImage = new Container(
      height: 56.0,
      width: 56.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${viewModel.user.profileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

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
      onTap: () => Keys.navigatorKey.currentState.push(MaterialPageRoute(
          builder: (_) => EditProfilePage(viewModel.user))),
    );

    final settingsButton = Container(
      height: 36,
      width: 36,
      child: Image.asset('assets/settings_icon.png', width: 36, height: 36),
    );

    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profileImage,
          Expanded(child: Container(),),
          editButton,
          settingsButton
        ],
      ),
    );
  }

  Widget _buildAbout(BuildContext context, MyProfileViewModel viewModel) {
    final nicknameBox = Container(
      child: Text(viewModel.user.nickname, style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.24,
        fontWeight: FontWeight.w700
      )),
    );

    final nameBox = Container(
      margin: EdgeInsets.only(top: 2),
      child: Text('Fury The Cat', style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.24,
        color: Color.fromRGBO(51, 51, 51, 0.7)
      )),
    );

    final aboutBox = isBlank(viewModel.user.about) ? Container() : Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(viewModel.user.about, style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.24,
        height: 20.0 / 14,
        color: Color.fromARGB(255, 51, 51, 51)
      )),
    );

    final divider = Container(
      margin: EdgeInsets.only(top: 11),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromARGB(255, 242, 242, 242)
          )
        )
      )
    );

    return Container(
      margin: EdgeInsets.only(top: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          nicknameBox,
          nameBox,
          aboutBox,
          divider
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context, MyProfileViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsBlock(context, 25, 'Записей'),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: _buildStatsBlock(context, viewModel.user.stats.followers, 'Подписчиков'),
          ),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: _buildStatsBlock(context, viewModel.user.stats.following, 'Подписок'),
          )
        ]
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 20,
      color: Color.fromARGB(255, 242, 242, 242),
    );
  }
  
  Widget _buildStatsBlock(BuildContext context, int count, String desc) {
    return Container(
      height: 44,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(count.toString(), style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.27,
            color: Color.fromARGB(255, 51, 51, 51)
          ),),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(desc, style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.21,
              color: Color.fromARGB(255, 153, 153, 153)
            ))
          )
        ],
      ),
    );
  }
}