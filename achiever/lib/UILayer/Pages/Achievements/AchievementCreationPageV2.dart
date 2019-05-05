import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/AchievementCategories/AchievementCategory.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

import 'SelectedAchievement/SelectedAchievementPage.dart';
import 'SelectedAchievement/SelectedAchievementViewModel.dart';

import 'package:achiever/BLLayer/ApiInterfaces/IAchievementApi.dart';
import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/BLLayer/Models/Achievement/ImageInfo.dart' as achiever;
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/Achievement/AcquiredAtDto.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/AppContainer.dart';

import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AchievementCreationPageV2 extends StatefulWidget {
  final AchievementCategory category;

  AchievementCreationPageV2(this.category, {Key key}) : super(key: key);

  @override
  _AchievementCreationPageV2State createState() => _AchievementCreationPageV2State();
}

class _AchievementCreationPageV2State extends State<AchievementCreationPageV2> {
  final _titleController = TextEditingController(text: 'Название');
  final _descriptionController = TextEditingController(text: 'Описание');

  bool submitting = false;

  _TmpImageInfo _bigImageInfo = _TmpImageInfo(), _frontImageInfo = _TmpImageInfo(), _backImageInfo = _TmpImageInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Новая ачивка'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildLayout(context)
    );
  }

  Widget _buildLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFitted(context, _buildTitleAndDescription(context)),
          Container(height: 10,),
          _buildFitted(context, _buildImageBox(context, _bigImageInfo, 'Большая фотка')),
          _buildFitted(context, _buildImageBox(context, _frontImageInfo, 'Маленькая фотка')),
          _buildFitted(context, _buildImageBox(context, _backImageInfo, 'Широкий задник')),
          _buildFitted(context, _buildFakedAchievementTile(context)),
          _buildFakedSelectedAchievementPage(context),
          _buildFitted(context, _buildSubmitButton(context))
        ]
      ),
    );
  }

  Widget _buildFakedAchievementTile(BuildContext context) {
    final achievement = _getFakedAchievement();

    var content = achievement.paintingType == AchievementPaintingType.unknown
      ? Container(
        height: 150,
        color: Colors.blue,)
      : AchieverAchievement(achievement, 123, null, null,
        key: UniqueKey(), useFileImages: true,);

    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: content,
    );
  }

  Widget _buildFakedSelectedAchievementPage(BuildContext context) {
    final achievement = _getFakedAchievement();

    if (achievement.paintingType == AchievementPaintingType.unknown) return Container(
      height: 500,
      color: Colors.blue,
    );

    final fakedViewModel = SelectedAchievementViewModel(
      category: widget.category,
      achievement: achievement
    );

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: 600),
        child: SelectedAchievementPage(fakedViewModel.achievement.id, 
          achievementApi: _AchievementApiMock(), 
          fakedViewModel: fakedViewModel,
          key: UniqueKey(),
        ),
    );
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextInput(context, _titleController, 'Название'),
        _buildTextInput(context, _descriptionController, 'Описание', allowMultiline: true)
      ],
    );
  }

  Widget _buildTextInput(BuildContext context, TextEditingController controller, String hintValue,
    {bool allowMultiline = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintValue,
      ),
      maxLines: allowMultiline ? null : 1,
    );
  }

  Widget _buildImageBox(BuildContext context, _TmpImageInfo imageInfo, String title) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            Container(
              height: 96, width: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 242, 242, 242),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset('assets/add_photo_icon.png', width: 48, height: 33,)
            ),
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(title, style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                letterSpacing: -0.41,
                color: Color.fromRGBO(51, 51, 51, 0.5)
              )),
            )
          ]
        ),
        onTap: () => _setImage(imageInfo),
      )
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 36),
      child: AchieverButton.createDefault(Text(submitting ? 'Создаем...' : 'Добавить в Achiever', style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        letterSpacing: 0.26,
        color: Colors.white
      )), submitting 
        ? () => {print('ololo')} 
        : () => _submitAchievement()),
    );
  }

  Widget _buildFitted(BuildContext context, Widget child) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: child,
    );
  }

  Achievement _getFakedAchievement() {
    return Achievement('fake_id_123', _titleController.text, _descriptionController.text, 
      null, null,
      _getImageInfo(_bigImageInfo),
      _getImageInfo(_backImageInfo),
      _getImageInfo(_frontImageInfo),
      false, null, widget.category);
  }

  Future _submitAchievement() async {
    setState(() {
      submitting = true;
    });
    try {
      await AppContainer.achievementApi.createAchievement(_getFakedAchievement());
    }
    finally {
      if (mounted)
        setState(() {
          submitting = false;
        });
    }
  }

  achiever.ImageInfo _getImageInfo(_TmpImageInfo imageInfo) {
    if (imageInfo.filePath == null) return null;

    return achiever.ImageInfo(imageInfo.filePath, 
      imageInfo.width, imageInfo.height);
  }

  Future<File> _pickAndCrop() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return null;

    final croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );
    if (croppedFile == null) return null;

    return croppedFile;
  }

  Future<ui.Image> _getImageDimensions(File file) async {
    final image = Image.file(file);
    final completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration())
      .addListener((ImageInfo info, bool _) => completer.complete(info.image));
    
    return await completer.future;
  }

  Future _setImage(_TmpImageInfo imageInfo) async {
    final file = await _pickAndCrop();

    if (file == null) return;
    
    final image = await _getImageDimensions(file);

    imageInfo.filePath = file.path;
    imageInfo.height = image.height;
    imageInfo.width = image.width;

    if (mounted)
      setState(() {});
  }
}

class _TmpImageInfo {
  String filePath;
  int width;
  int height;
}

class _AchievementApiMock extends IAchievementApi {
  Future<List<Achievement>> getAll() => Future.value(null);

  Future<List<Achievement>> getByCategory(String categoryId) => Future.value(null);

  Future<List<Achievement>> getMyByCategory(String categoryId) => Future.value(null);

  Future<Achievement> getById(String id) => Future.value(null);

  Future<List<UserDto>> getFollowingsWhoHave(String achievementId) => Future.value([]);

  Future createAchievement(Achievement model) => Future<Null>(null);

  Future<List<AchievementCategory>> getAllCategories() => Future.value(null);

  Future<AcquiredAtDto> checkIHave(String achievementId) => Future.value(AcquiredAtDto(true, "завтра"));
}