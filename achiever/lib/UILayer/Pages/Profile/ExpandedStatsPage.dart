import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/UILayer/UIKit/User/UserTile.dart';

class ExtendedStatsPage extends StatelessWidget {
  final Future<List<UserDto>> _getUsersFuture;

  ExtendedStatsPage(this._getUsersFuture, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildLayout(context);
  }

  Widget _buildLayout(BuildContext context) {
    return _buildFitted(context, 
      FutureBuilder(
        future: _getUsersFuture,
        builder: (innerContext, AsyncSnapshot<List<UserDto>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data.map((x){
                  return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: UserTile(x, key: ValueKey(x.user.id))
                  );
                }).toList(),
              ),
            );
          }
          else return Center(
            child: CircularProgressIndicator()
          );
        },
      )
    );
  }

  Widget _buildFitted(BuildContext context, Widget body) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: body,
    );
  }
}