import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:achiever/AppContainer.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';
import 'package:achiever/UILayer/UIKit/Images/AchieverImage.dart';
import 'package:achiever/BLLayer/Models/Feed/CreateEntryByAchievementRequest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:achiever/DALayer/ApiClient.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class EntryCreationPage extends StatefulWidget {
  final String achievementId;
  EntryCreationPage(this.achievementId);

  @override
  _EntryCreationPageState createState() => _EntryCreationPageState(achievementId);
}

class _EntryCreationPageState extends State<EntryCreationPage> {
  final String achievementId;
  
  final _achievementApi = AppContainer.achievementApi;
  final _feedApi = AppContainer.feedApi;

  final _imagesScrollController = new ScrollController();
  final List<File> _imagesList = new List<File>();
  final commentText = 'Константный длинный комментарий, который пока что нельзя менять, т.к. мне впадлу снова ебаться с клавиатурой';

  String commentTextNew = '';

  bool achievementLoaded = false;
  Achievement achievement;

  bool _uploadInProgress = false;

  _EntryCreationPageState(this.achievementId);

  @override
  void initState() {
    _achievementApi.getById(achievementId).then((data){
      setState(() {
                achievementLoaded = true;
                achievement = data;
              });
    });
    super.initState();
  }

  Future _addImageToList() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    final croppedFile = await ImageCropper.cropImage(
      ratioX: 1.0,
      ratioY: 1.0,
      sourcePath: imageFile.path,
    );
    if (croppedFile == null) return;

    setState(() {
          _imagesList.add(croppedFile);
        });
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _imagesScrollController.animateTo(
        _imagesScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut
      );
    });
  }

  Future _sendPost(BuildContext context) async {
    setState(() {
          _uploadInProgress = true;
        });
    final request = CreateEntryByAchievementRequest(achievementId, commentTextNew);
    _feedApi.createFeedEntryByAchievement(request, _imagesList).then((x) {
      Navigator.of(context).pop();
    })
    .catchError((e) {
      setState(() {
              _uploadInProgress = false;
            });
    });
  }

  void _removeImageFromList(File image) {
    setState(() {
          _imagesList.remove(image);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text('Новый пост'),
      ),
      body: !achievementLoaded ? new Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ) : buildLayout(context),
    );
  }

  Widget buildLayout(BuildContext context) {
    final achievementBox = new Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 1.0)),
      margin: EdgeInsets.only(top: 28.0, left: 16.0, right: 16.0),
      child: AchieverAchievement(achievement,
        MediaQuery.of(context).size.width - 16 * 2,
        CachedNetworkImageProvider('${ApiClient.staticUrl}/${achievement.backgroundImage.imagePath}'),
        CachedNetworkImageProvider('${ApiClient.staticUrl}/${achievement.frontImage.imagePath}')),
    );

    final List<Widget> photosList = _imagesList.map((file){
      return new Container(
        //height: 250.0,
        height: 96.0,
        width: 96.0,
        margin: EdgeInsets.only(right: 16.0),
        child: new Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            AchieverImage(96, 96, FileImage(file)),
            GestureDetector(
              onTap: () => _removeImageFromList(file),
              child: Container(
                child: Image.asset('assets/cancel_icon.png', width: 24, height: 24),
                margin: EdgeInsets.only(top: 4.0, right: 4.0)
              )
            )
          ]
        )
      );
    }).toList();
    photosList.add(
      Container(
        child: GestureDetector(
          onTap: () => _addImageToList(),
          child: Container(height: 96, width: 96,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset('assets/add_photo_icon.png', width: 48, height: 33,)
          )
        )
      )
    );

    final photosBox = new Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 96.0 + 26,
      child: new ScrollConfiguration(
        behavior: NoScrollGlowBehavior(),
        child: SingleChildScrollView(
          controller: _imagesScrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 16.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: photosList
          )
        )
      )
    );

    final hintBox = new Container(
      margin: EdgeInsets.only(top: 2.0, left: 16.0),
      child: new Text('Расскажите о вашем достижении', style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: Color.fromARGB(255, 102, 102, 102)
      ), textAlign: TextAlign.left,),
    );

    final constCommentBox = new Container(
      margin: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
      child: new Text(commentText, 
        style: TextStyle(
          fontSize: 17.0,
          height: 1.33
        ),
      ),
    );

    final commentInput = Container(
      margin: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
      child: new TextField(
        maxLength: 200,
        maxLines: null,
        onChanged: (val) => commentTextNew = val,
      ),
    );

    final brBox = new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      height: 0,
      decoration: BoxDecoration(border: Border(top: BorderSide(
        color: Color.fromARGB(255, 216, 216, 216), width: 1.0))),
    );

    final submitButton = _uploadInProgress ? new Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ) : new Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0, bottom: 26.0),
      child: AchieverButton.createDefault(new Text('ОПУБЛИКОВАТЬ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ), () => _sendPost(context))
    );

    return new SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          achievementBox,
          photosBox,
          hintBox,
          //constCommentBox,
          commentInput,
          brBox,
          submitButton
        ],
      ),
    );
  }
}