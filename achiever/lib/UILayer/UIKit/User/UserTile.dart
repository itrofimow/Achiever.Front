import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import '../Images/AchieverProfileImage.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/AppContainer.dart';
import 'package:quiver/strings.dart';
import 'dart:async';

class UserTile extends StatefulWidget {
  final UserDto user;

  UserTile(this.user, {Key key}) : super(key: key);

  @override
  UserTileState createState() => UserTileState(user);
}

class UserTileState extends State<UserTile> {
  final UserDto user;

  bool following;
  bool isLoading = false;

  UserTileState(this.user) {
    following = user.following;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      child: Row(
        children: <Widget>[
          _buildProfileImage(context),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: _buildNicknameAndName(context),
          ),
          Expanded(child: Container()),
          _buildIcon(context)
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return AchieverProfileImage(36, 
      CachedNetworkImageProvider('${ApiClient.staticUrl}/${user.user.profileImagePath}'));
  }

  Widget _buildNicknameAndName(BuildContext context) {
    final columnChildren = <Widget>[
      Text(user.user.nickname, style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        letterSpacing: 0.24,
        color: Color.fromRGBO(51, 51, 51, 1)
      ),),
    ];
    if (!isBlank(user.user.displayName)) {
      columnChildren.add(
        Text(user.user.displayName, style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.24,
          color: Color.fromRGBO(51, 51, 51, 0.7)
        ))
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: columnChildren.length == 2 
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center,
      children: columnChildren
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: isLoading ? Center(
        widthFactor: 0.9,
        child: CircularProgressIndicator(),
      ) : GestureDetector(
        child: Image.asset(
          following ? 'assets/following_icon.png' : 'assets/follow_icon.png', 
          width: 36, height: 36),
        onTap: () {
          followOrUnfollow();
        },
      )
    );
  }

  Future followOrUnfollow() async {
    setState(() {
      isLoading = true;
    });

    final completer = Completer<bool>();
    bool success = false;

    if (following) {
      AppContainer.store.dispatch(unfollowAndReload(user.user.id, completer));
      
      success = await completer.future;
    }
    else {
      AppContainer.store.dispatch(followAndReload(user.user.id, completer));

      success = await completer.future;
    }

    setState(() {
      following ^= true & success;
      isLoading = false;      
    });
  }
}