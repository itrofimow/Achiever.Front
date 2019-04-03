import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileBuilder {
  static Widget buildProfileHeader(bool isLoading, User model) {
    final profileImage = new Container(
      margin: EdgeInsets.only(top: 20.0),
      width: 98.0,
      height: 98.0,
      //decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
      child: new ClipRRect(
        borderRadius: new BorderRadius.circular(50.0),
        child: isLoading ? new Container() : new Image.network(
          ApiClient.staticUrl + '/' + model.profileImagePath, height: 98.0, width: 98.0),
      )
      //new CachedNetworkImage(imageUrl: BackendApi.staticUrl + '/uploads/image_cropper_1543600151641.jpg', height: 98.0, width: 98.0),
    );

    final nicknameBox = new Container(
      margin: EdgeInsets.only(top: 12.0),
      height: 20.0,
      child: new Text(isLoading ? '...' : '@${model.nickname}', style: new TextStyle(
        color: Color.fromARGB(255, 51, 51, 51),
        fontSize: 14.0,
        fontWeight: FontWeight.w600
      )),
    );

    final statsBox = new Container(
      margin: EdgeInsets.only(top: 12.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      width: 360.0,
      height: 48.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getStatBox(isLoading ? '...' : '${model.stats.following}', 'Подписок'),
          _getStatBox(isLoading ? '...' : '${model.stats.followers}', 'Последователей'),
          _getStatBox(isLoading ? '...' : '${model.stats.achievementsCount}', 'Достижений'),
        ],
      ),
    );

    final profileHeader = new Container(
      //decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.red)),
      width: 360.0,
      height: 210.0,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          profileImage,
          nicknameBox,
          statsBox
        ],
      ),
    );

    return profileHeader;
  }

  static StatelessWidget _getStatBox(String cnt, String text) {
    return new Container(
      width: 100.0,
      height: 48.0,
      color: Colors.white,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            height: 20.0,
            child: new Text(cnt, style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            )),
          ),
          new Container(
            margin: EdgeInsets.only(top: 8.0),
            height: 20.0,
            child: new Text(text, style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w100,
              color: Color.fromARGB(255, 153, 153, 153)
            ))
          )
        ],
      ),
    );
  }
}