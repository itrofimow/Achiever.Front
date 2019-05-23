import 'package:flutter/material.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/UILayer/UIKit/Images/AchieverProfileImage.dart';
import 'package:achiever/DALayer/ApiClient.dart';
import 'package:achiever/UILayer/UIKit/Buttons/AchieverButton.dart';

import 'MyProfileViewModel.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';

import 'package:achiever/BLLayer/Redux/Keys.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/UILayer/UXKit/PhotoSelector.dart';

import 'package:achiever/UILayer/UXKit/PhotoSelector.dart';

import 'dart:io';
import 'dart:async';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);
  
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  bool isSavingChanges = false;
  File newImage;

  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.user.displayName;
    _nicknameController.text = widget.user.nickname;
    _aboutController.text = widget.user.about;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _aboutController.dispose();

    super.dispose();
  }

  Future _selectPhoto() async {
    final croppedImage = await PhotoSelector.selectPhoto(context, allowCamera: true, applyCropper: true);

    //final test = await PhotoSelector.selectPhoto();

    /*final image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final croppedImage = await ImageCropper.cropImage(sourcePath: image.path);*/

    if (mounted) {
      setState(() {
        newImage = croppedImage;
      });
    }
  }

  void _saveChanges(Store<AppState> store) {
    setState(() {
      isSavingChanges = true;
    });

    final completer = Completer<Null>();
    store.dispatch(updateUserV2(newImage, 
      _nameController.text, _nicknameController.text, _aboutController.text, completer));

    completer.future.then((_){
      setState(() {
        isSavingChanges = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) => _buildLayout(context, store),
    );
  }

  Widget _buildLayout(BuildContext context, Store<AppState> store) {
    return Scaffold(
      appBar: _buildAppBar(context, store),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: <Widget>[
            _buildImageBlock(context),
            _buildInfoBlock(context)
          ],
        )
      )
    );
  }

  Widget _buildAppBar(BuildContext context, Store<AppState> store) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              child: Text('Отмена', style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.24,
                color: Color.fromARGB(255, 51, 51, 51)
              )),
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          Text('Редактирование', style: TextStyle(
            fontSize: 21,
            letterSpacing: 0.34,
            color: Color.fromARGB(255, 51, 51, 51),
            fontWeight: FontWeight.w700
          ),),
          isSavingChanges ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            constraints: BoxConstraints(minWidth: 50),
          ) : GestureDetector(
            child: Container(
              constraints: BoxConstraints(minWidth: 50),
              child: Text('Готово', style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.24,
                color: Color.fromARGB(255, 51, 51, 51)
              ), textAlign: TextAlign.right,),
            ),
            onTap: () => _saveChanges(store)
          ),
        ]
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildImageBlock(BuildContext context) {
    final profileImage = Container(
      height: 56.0,
      width: 56.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: newImage == null ? CachedNetworkImage(imageUrl: '${ApiClient.staticUrl}/${widget.user.profileImagePath}',
          width: 36.0, height: 36.0,) :
        Image.file(newImage)
      ),
    );

    final changeImageButton = GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Color.fromARGB(255, 242, 242, 242)
          ),
          height: 36,
          child: Center(
            widthFactor: 1,
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text('Сменить фото профиля', style: TextStyle(
                fontSize: 13,
                letterSpacing: 0.22,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 51, 51, 51)
              )),
            ),
          ),
        ),
      ),
      onTap: () => _selectPhoto(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileImage,
        Container(
          margin: EdgeInsets.only(top: 12),
          child: changeImageButton
        )
      ],
    );
  }

  Widget _buildInfoBlock(BuildContext context) {
    final informationBox = Text('ИНФОРМАЦИЯ О СЕБЕ', style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.95,
      color: Color.fromRGBO(51, 51, 51, 0.3),
    ),);

    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          informationBox,
          Container(
            margin: EdgeInsets.only(top: 16),
            child: _buildInputBox(context, 'Имя', _nameController),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: _buildInputBox(context, 'Никнейм', _nicknameController),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: _buildInputBox(context, 'О себе', _aboutController, 
              allowMultiLine: true),
          )
        ],
      ),
    );
  }

  Widget _buildInputBox(BuildContext context, String label, TextEditingController controller,
    {bool allowMultiLine = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 12,
          height: 16.0 / 12
        ),
        labelText: label
      ),
      maxLines: allowMultiLine ? null : 1,
    );
  }
}

/*class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editFormKey = GlobalKey<FormState>();

  final _nicknameController = TextEditingController();
  final _aboutController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _aboutController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('edit profile'),
      ),
      body: StoreConnector<AppState, MyProfileViewModel>(
        onInit: (store) {
          _nicknameController.text = store.state.draftState.newNickname;
          _aboutController.text = store.state.draftState.newAbout;
        },
        converter: (store) => MyProfileViewModel.fromStore(store),
        builder: (_, viewModel) => _buildLayout(viewModel)
      )
    );
  }

  Widget _buildLayout(MyProfileViewModel viewModel) {
    final profileImage = Center(child: Container(
      margin: EdgeInsets.only(top: 20.0),
      child: AchieverProfileImage(98.0, NetworkImage(
        ApiClient.staticUrl + '/' + viewModel.newProfileImagePath,
        )
      )
    ));

    final changeImageText = Container(
      margin: EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        child: Text('Сменить фото профиля', style: 
          TextStyle(color: Color.fromARGB(255, 72, 128, 225)),
          textAlign: TextAlign.center,
        ),
        onTap: () => {},
      )
    );

    final dividerLine = Container(
      margin: EdgeInsets.only(top: 23.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, 
            color: Color.fromARGB(255, 216, 216, 216)))
      ),
    );

    final editColumn = _buildForm(viewModel);

    return SingleChildScrollView(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          profileImage,
          changeImageText,
          dividerLine,
          editColumn,
          Container(
            margin: EdgeInsets.only(top: 10),
            child: AchieverButton.createDefault(
              Text('ЗАЕБОШИТЬ', style: TextStyle(color: Colors.white),), 
              () => viewModel.update())
          )
        ],
      )
    );
  }

  Widget _buildForm(MyProfileViewModel viewModel) {
    final nameField = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 80,
          padding: EdgeInsets.only(top: 15),
          child: Text('Имя', style: TextStyle(
            color: Color.fromARGB(255, 51, 51, 51),
            fontWeight: FontWeight.w600
          )),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 4.0),
            child: TextFormField(
              maxLength: 50,
            ),
          )
        )
      ],
    );

    final nicknameField = Container(
      margin: EdgeInsets.only(top: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            padding: EdgeInsets.only(top: 15),
            child: Text('Никнейм', style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontWeight: FontWeight.w600
            )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              child: TextField(
                maxLength: 20,
                controller: _nicknameController,
                onChanged: (nickname) => viewModel.updateDraft(
                  nickname,
                  viewModel.newAbout,
                  viewModel.newProfileImagePath),
              ),
            )
          )
        ],
      )
    );

    final aboutField = Container(
      margin: EdgeInsets.only(top: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            padding: EdgeInsets.only(top: 15),
            child: Text('О себе', style: TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontWeight: FontWeight.w600
            )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              child: TextField(
                maxLength: 200,
                maxLines: null,
                controller: _aboutController,
                onChanged: (about) => viewModel.updateDraft(
                  viewModel.newNickname,
                  about,
                  viewModel.newProfileImagePath
                ),
              ),
            )
          )
        ],
      )
    );

    final editForm = Form(
      key: editFormKey,
      child: Container(
        margin: EdgeInsets.only(left: 20.0, top: 11.0, right: 20.0),
        child: Column(
          children: <Widget>[
            nameField,
            nicknameField,
            aboutField    
          ],
        )
      )
    );

    return editForm;
  }
}*/