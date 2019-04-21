import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'FeedEntryViewModel.dart';
import '../FeedTile.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryComment.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FeedEntryPage extends StatelessWidget {
  final String feedEntryId;

  FeedEntryPage(this.feedEntryId);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FeedEntryViewModel>(
      converter: (store) => FeedEntryViewModel.fromStore(store, feedEntryId),
      builder: (context, viewModel) => _buildLayout(context, viewModel),
    );
  }

  Widget _buildLayout(BuildContext context, FeedEntryViewModel viewModel) {
    final columnChildren = <Widget>[
      FeedTile(viewModel.model, false, 
        (_) => viewModel.likeOrUnlikeCallback(), (_, __) => {}, "we"),
      Container(
        margin: EdgeInsets.only(top: 12.0, left: 16.0),
        child: Text('КОММЕНТАРИИ ${viewModel.model.entry.commentsCount}', style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: 0.95,
          color: Color.fromRGBO(88, 89, 94, 0.5)
        ),),
      )
    ];

    viewModel.model.entry.comments.forEach((x){
      columnChildren.add(_buildSingleComment(context, x));
    });

    final inputBox = Container(
      margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
      child: TextField(
        maxLength: null,
        textInputAction: TextInputAction.send,
        onSubmitted: (val) => viewModel.addCommentFunc(val),
      ),
    );
    columnChildren.add(inputBox);

    return ListView(
      children: columnChildren,
    );
  }

  Widget _buildSingleComment(BuildContext context, FeedEntryComment comment) {
    final profileImage = new Container(
      height: 36.0,
      width: 36.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${comment.authorProfileImage}',
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
          Text(comment.authorNickname, style: TextStyle(
            color: Color.fromARGB(255, 51, 51, 51),
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            letterSpacing: 0.24,
            //height: 18 / 14
          ),),
          Text(comment.text, style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 0.24
          ),),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text(comment.when, style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 0.7),
              fontSize: 12.0,
              letterSpacing: 0.21,
            ))
          ),
        ],
      )
    );

    return Container(
        margin: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            profileImage,
            Expanded(child: nicknameAndTextBox)
          ],
        )
      );
  }
}