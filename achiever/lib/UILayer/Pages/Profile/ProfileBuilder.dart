import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:quiver/strings.dart';

class ProfileBuilder {
  static Widget buildAbout(BuildContext context, User user) {
    final nicknameBox = Container(
      child: Text(user.nickname, style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.24,
        fontWeight: FontWeight.w700
      )),
    );

    final nameBox = isBlank(user.displayName) ? Container() : Container(
      margin: EdgeInsets.only(top: 2),
      child: Text(user.displayName, style: TextStyle(
        fontSize: 14,
        letterSpacing: 0.24,
        color: Color.fromRGBO(51, 51, 51, 0.7)
      )),
    );

    final aboutBox = isBlank(user.about) ? Container() : Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(user.about, style: TextStyle(
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

  static Widget buildStatsBlock(BuildContext context, int count, String desc) {
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

  static Widget buildDivider(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 20,
      color: Color.fromARGB(255, 242, 242, 242),
    );
  }
}