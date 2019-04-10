import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'NotificationsViewModel.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/Notifications/AchieverNotification.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';

class NotificationsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NotificationsViewModel>(
      converter: (store) => NotificationsViewModel.fromStore(store),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, NotificationsViewModel viewModel) {
    final listChildren = <Widget> [
      Text('НОВЫЕ', style: TextStyle(
        fontSize: 15,
        letterSpacing: 0.95,
        color: Color.fromRGBO(88, 89, 94, 0.5)
      ))
    ];

    viewModel.notifications.forEach((x){
      listChildren.add(_buildSingleNotification(context, x));
    });

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.fetchNotifications();
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 16, right: 16),
        child: ListView(
          children: listChildren,
        ),
      ),
    );
  }

  Widget _buildSingleNotification(BuildContext context, AchieverNotification notification) {
    final profileImage = new Container(
      height: 36.0,
      width: 36.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${notification.author.profileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

    final nicknameAndTextBox = Container(
      margin: EdgeInsets.only(left: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(notification.author.nickname, style: TextStyle(
            color: Color.fromARGB(255, 51, 51, 51),
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 0.24,
            //height: 18 / 14
          ),),
          Text('«${notification.text}»', style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 0.24
          ),),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text('14 feb. 14:02', style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 0.7),
              fontSize: 12.0,
              letterSpacing: 0.21,
            ))
          ),
        ],
      )
    );

    final achievementImage = Container(
      width: 36, height: 36,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/uploads/image_cropper_1552135907512.jpg', width: 36, height: 36,)
      )
    );

    return Container(
      margin: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profileImage,
            Expanded(child: nicknameAndTextBox),
            achievementImage
          ],
        )
      );
  }
}