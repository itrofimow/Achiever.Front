import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import '../Images/AchieverProfileImage.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserTile extends StatelessWidget {
  final UserDto user;

  UserTile(this.user);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(user.user.nickname, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 0.24,
          color: Color.fromRGBO(51, 51, 51, 1)
        ),),
        Text(user.user.nickname, style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.24,
          color: Color.fromRGBO(51, 51, 51, 0.7)
        ))
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: Image.asset(
        user.following ? 'assets/following_icon.png' : 'assets/follow_icon.png', 
        width: 36, height: 36,),
    );
  }
}