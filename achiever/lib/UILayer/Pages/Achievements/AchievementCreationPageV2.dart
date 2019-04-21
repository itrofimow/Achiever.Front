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

  File _bigImage;
  int _imageWidth;
  int _imageHeight;

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
          _buildFitted(context, Container(
            margin: EdgeInsets.only(top: 40),
            child: _buildImageBox(context),
          )),
          _buildFakedSelectedAchievementPage(context),    
          _buildFitted(context, _buildSubmitButton(context))
        ]
      ),
    );
  }

  Widget _buildFakedSelectedAchievementPage(BuildContext context) {
    if (_bigImage == null) return Container(
      height: 500,
      color: Colors.blue,
    );

    final fakedViewModel = SelectedAchievementViewModel(
      category: widget.category,
      achievement: _getFakedAchievement()
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

  Widget _buildImageBox(BuildContext context) {
    return GestureDetector(
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
            child: Text('Большая фотка', style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
              letterSpacing: -0.41,
              color: Color.fromRGBO(51, 51, 51, 0.5)
            )),
          )
        ]
      ),
      onTap: () => _setBigImage(),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 36),
      child: AchieverButton.createDefault(Text('Добавить в Achiever', style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 15,
        letterSpacing: 0.26,
        color: Colors.white
      )), () => {print('ololo')}),
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
      achiever.ImageInfo(_bigImage.path, _imageWidth, _imageHeight), 
      null, null, false, null, widget.category);
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

  Future _setBigImage() async {
    final file = await _pickAndCrop();

    if (file == null) return;
    
    final image = await _getImageDimensions(file);

    if (mounted)
      setState(() {
          _bigImage = file;
          _imageWidth = image.width;
          _imageHeight = image.height;
        });
  }
}

class _AchievementApiMock extends IAchievementApi {
  Future<List<Achievement>> getAll() => Future.value(null);

  Future<List<Achievement>> getByCategory(String categoryId) => Future.value(null);

  Future<List<Achievement>> getMyByCategory(String categoryId) => Future.value(null);

  Future<Achievement> getById(String id) => Future.value(null);

  Future<List<UserDto>> getFollowingsWhoHave(String achievementId) => Future.value([]);

  Future createAchievement(Achievement model, File backgroundImage, File foregroundImage) => Future<Null>(null);

  Future<List<AchievementCategory>> getAllCategories() => Future.value(null);

  Future<AcquiredAtDto> checkIHave(String achievementId) => Future.value(AcquiredAtDto(true, "завтра"));
}