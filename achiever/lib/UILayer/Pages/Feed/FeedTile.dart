import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/Feed/FeedEntryResponse.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/UILayer/UIKit/Images/AchieverImage.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/UILayer/Pages/Profile/MyProfile/MyProfilePage.dart';
import 'package:achiever/UILayer/Pages/Profile/TheirProfilePage.dart';
import 'FeedEntry/FeedEntryPage.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:quiver/strings.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Redux/Navigation/NavigationActions.dart';
import 'package:achiever/UILayer/UIKit/NoOpacityMaterialPageRoute.dart';
import '../Profile/ExpandedStatsPage.dart';

class NoScrollGlowBehavior extends ScrollBehavior {

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class FeedTile extends StatelessWidget {
	final FeedEntryResponse model;
  final bool _allowNavigation;
  final Function(String) _likeOrUnlikeCallback;
  final Function(BuildContext, FeedEntryResponse) _navigateToFeedEntry;
  final String userId;

	FeedTile(this.model, this._allowNavigation, 
    this._likeOrUnlikeCallback, this._navigateToFeedEntry,
    this.userId);

  void _goToProfile(BuildContext context) {
    if (!_allowNavigation) return;

    if (model.entry.authorId == userId)
      Navigator.of(context).push(NoOpacityMaterialPageRoute(
        builder: (context) => MyProfilePage(),
        settings: RouteSettings(name: 'my profile')
      ));
    else
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TheirProfilePage(model.entry.authorId),
        settings: RouteSettings(name: model.authorNickname)
      ));
  }

	Widget build(BuildContext context) {
    final profileImage = new Container(
      height: 36.0,
      width: 36.0,
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: new CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${model.authorProfileImagePath}',
          width: 36.0, height: 36.0,)
      ),
    );

    final profileNickname = new Container(
      margin: EdgeInsets.only(left: 8.0),
      child: new Text('${model.authorNickname}', style: new TextStyle(
        color: Color.fromARGB(255, 51, 51, 51),
        fontSize: 12,
        letterSpacing: 0.21,
        fontWeight: FontWeight.w600
      )),
    );

    final whenBox = new Container(
      //margin: EdgeInsets.only(right: 16.0),
      child: new Text(model.entry.when, style: TextStyle(
        color: Color.fromARGB(255, 153, 153, 153),
        fontSize: 12.0,
        letterSpacing: 0.21,
        fontWeight: FontWeight.w200
      )),
    );

    final header = new Container(
      width: 328.0,
      height: 36.0,
      margin: EdgeInsets.only(top: 12.0, left: 16.0),
      /*decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0)
      ),*/
      //color: Colors.blue,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new GestureDetector(
            onTap: () => _goToProfile(context),
            child: Row(
              children: <Widget>[
                profileImage,
                profileNickname
              ]
            )
          ),
          whenBox
        ],
      ),
    );

    final achievementBox = Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: AchieverAchievement(model.entry.achievement,
        MediaQuery.of(context).size.width - 16 * 2,
        CachedNetworkImageProvider(ApiClient.staticUrl + '/' + model.entry.achievement.backgroundImage.imagePath),
        CachedNetworkImageProvider(ApiClient.staticUrl + '/' + model.entry.achievement.frontImage.imagePath)
      )
    );

    var photosBox = new Container();

    final size = MediaQuery.of(context).size.width - 16 * 2;
    if (model.entry.images.length == 1) {
      photosBox = new Container(
        /*decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0)
        ),*/
        margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: new AchieverImage(size, size, CachedNetworkImageProvider(
          '${ApiClient.staticUrl}/${model.entry.images[0]}'))
      );
    }

    else if (model.entry.images.length > 1) {
      photosBox = new Container(
        /*decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0)
        ),*/
        margin: EdgeInsets.only(top: 16.0),
        height: 261,
        child: new ScrollConfiguration(
          behavior: NoScrollGlowBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.0),
            child: new Row( 
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: model.entry.images.map((path) {
                return new Container(
                  //height: 250.0,
                  margin: EdgeInsets.only(right: 16.0),
                  child: AchieverImage(235, 235, CachedNetworkImageProvider(
                    '${ApiClient.staticUrl}/$path')),
                );
              }).toList()
            )
          )
        )
      );
    }

    final Container commentBox = isBlank(model.entry.comment) ? Container() : Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: model.entry.images.length > 1 ? 0.0 : 16.0),
      child: Text(model.entry.comment, style: TextStyle(
        fontSize: 14.0,
        height: 1.33,
        color: Color.fromARGB(255, 51, 51, 51),

      )),
    );

    final Container dividerLine = new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      child: Divider(
        color: Color.fromARGB(255, 216, 216, 216,), height: 1.0,
      ),
    );

    final likeOrUnlikeButton = GestureDetector(
      child: Image.asset(model.isLiked ? 
        'assets/heart_blue_icon.png' : 
        'assets/heart_icon.png', width: 24.0, height: 24.0,) ,
      onTap: () => _likeOrUnlikeCallback(model.entry.id),
      onLongPress: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ExtendedStatsPage(Future.value(model.entry.likedUsers)),
        settings: RouteSettings(name: 'Liked')
      )),
    );

    final toFeedEntryNavigator = GestureDetector(
      child: Image.asset('assets/comments_icon.png', width: 24.0, height: 24.0,),
      onTap: () => _navigateToFeedEntry(context, model)
    );

    final Container likesAndCommentsBox = new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      height: 26.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          likeOrUnlikeButton,
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 50.0),
            child: Text('${model.entry.likesCount}', style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600
            ),),
          ),
          toFeedEntryNavigator,
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 50.0),
            child: Text('${model.entry.commentsCount}', style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600
            ),),
          ),
        ],
      ),
    );

    final Container tileDivider = new Container(
      margin: EdgeInsets.only(top: 12.0),
      color: Color.fromARGB(255, 242, 242, 242), 
      height: 16.0,
      
    );

		return new Container(
			//margin: EdgeInsets.only(top: 100.0),
      //decoration: new BoxDecoration(border: Border.all(color: Colors.black, width: 1.0,)),
			//decoration: new BoxDecoration(border: new Border.all(color: Colors.green, width: 1.0)),
			child: new Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
          header,
					achievementBox,
          photosBox,
          commentBox,
          dividerLine,
          likesAndCommentsBox,
          tileDivider
				]
			)
		);
	}
}