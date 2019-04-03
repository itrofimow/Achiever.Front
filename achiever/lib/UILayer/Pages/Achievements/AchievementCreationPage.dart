import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'dart:ui' as ui;

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:achiever/BLLayer/Models/Achievement/Achievement.dart';
import 'package:achiever/UILayer/UIKit/Achievement/AchieverAchievement.dart';
import 'package:achiever/BLLayer/Models/Achievement/ImageInfo.dart' as Achiever;
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

import 'package:achiever/AppContainer.dart';

class AchievementCreationPage extends StatefulWidget {
  @override
  _AchievementCreationPageState createState() => _AchievementCreationPageState();
}

class _AchievementCreationPageState extends State<AchievementCreationPage> {
  final _achievementApi = AppContainer.achievementApi;

  File _backgroundImageFile;
  File _frontImageFile;

  String _title = 'Название', _description = 'Описание';
  final _formKey = new GlobalKey<FormState>();

  final _titleFocusNode = new FocusNode();
  final _descriptionFocusNode = new FocusNode();

  int _imageWidth = -1;
  int _imageHeight = -1;

  double _contentWidth = -1;

  double _getWidth(BuildContext context) {
    if (_contentWidth < 0) return MediaQuery.of(context).size.width - 16 * 2;

    return _contentWidth;
  }

  Future<File> _pickAndCrop(double ratioX, double ratioY) async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return null;

    final croppedFile = await ImageCropper.cropImage(
      ratioX: ratioX,
      ratioY: ratioY,
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

  Future _setBackgroundImage() async {
    final file = await _pickAndCrop(3.0, 1.0);

    if (file == null) return;
    
    final image = await _getImageDimensions(file);

    if (mounted)
      setState(() {
          _backgroundImageFile = file;
          _imageWidth = image.width;
          _imageHeight = image.height;
        });
  }

  Future _setFrontImage() async {
    final file = await _pickAndCrop(1.0, 1.3);

    if (file != null) {
      setState(() {
        _frontImageFile = file;        
            });
    }
  }

  Future _updateTitle() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted || _titleFocusNode.hasFocus) return;
    
    _formKey.currentState.save();

    setState(() {
          
        });
  }

  Future _updateDescription() async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted || _descriptionFocusNode.hasFocus) return;

    _formKey.currentState.save();

    setState(() {
          
        });
  }

  Future _submit() async {
    try {
      await _achievementApi.createAchievement(
        Achievement('we', _title, _description, 'we', 'we', null, null, null, false, null, null), 
        _backgroundImageFile, _frontImageFile);
    }
    catch(e) {
      
    }
  }

  @override
  void initState() {
      _titleFocusNode.addListener(_updateTitle);
      _descriptionFocusNode.addListener(_updateDescription);
      super.initState();
    }

  @override
  void dispose() {
      _titleFocusNode.removeListener(_updateTitle);
      _descriptionFocusNode.removeListener(_updateDescription);
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text('Create Achievement'),
      ),
      body: SingleChildScrollView(
        child: _buildLayout(context),
      ) 
    );
  }

  Widget _buildLayout(BuildContext context) {
    final _key = null;//UniqueKey();

    final model = Achievement('we', _title, _description, 'we', 'we', 
      Achiever.ImageInfo('we', _imageWidth, _imageHeight),
      Achiever.ImageInfo('we', (80 / 1.3).toInt(), 80),
      Achiever.ImageInfo('we', 0, 0), false, null, null);
    final achievementBox = (_backgroundImageFile == null || _frontImageFile == null) ? 
      Container(height: 200.0, color: Colors.red,) : 
    Container(
      child: AchieverAchievement(model,
        _getWidth(context),//MediaQuery.of(context).size.width - 16 * 2.0,
        FileImage(_backgroundImageFile),
        FileImage(_frontImageFile),
        key: _key,)
    );

    final setBackgroundBox = Container(
      child: GestureDetector(
        onTap: () => _setBackgroundImage(),
        child: Container(height: 96, width: 96,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color.fromARGB(255, 64, 123, 224), width: 1.0)
          ),
          child: Icon(Icons.add_a_photo, size: 50.0, color: Color.fromARGB(255, 64, 123, 224),),
        )
      )
    );

    final setFrontBox = Container(
      child: GestureDetector(
        onTap: () => _setFrontImage(),
        child: Container(height: 96, width: 96,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Color.fromARGB(255, 64, 123, 224), width: 1.0)
          ),
          child: Icon(Icons.add_a_photo, size: 50.0, color: Color.fromARGB(255, 64, 123, 224),),
        )
      )
    );

    final actionsBox = new Container(
      margin: EdgeInsets.only(top: 20.0),
      child: new Row(
        children: <Widget>[
          setBackgroundBox,
          setFrontBox
        ],
      ),
    );

    final inputsBox = new Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: _titleFocusNode,
              decoration: InputDecoration(
                labelText: 'Название'
              ),
              onSaved: (val) => _title = val,
            ),
            TextFormField(
              focusNode: _descriptionFocusNode,
              decoration: InputDecoration(
                labelText: 'Описание'
              ),
              onSaved: (val) => _description = val,
            )
          ],
        ),
      )
    );

    final widthSlider = Container(
      margin: EdgeInsets.only(top: 16),
      child: Slider(
        value: _getWidth(context),
        min: 300.0,
        max: 900.0,
        onChanged: (val){
          setState(() {
            _contentWidth = val;
          });
        },
      )
    );

    final submitButton = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: AchieverButton.createDefault(new Text('SUBMIT', style: TextStyle(
        color: Colors.white
        ),
      ), () => _submit())
    );

    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0, bottom: 30.0),
      child: Column(
        children: <Widget>[
          achievementBox,
          actionsBox,
          inputsBox,
          //widthSlider,
          submitButton
        ],
      )
    );
  }
}