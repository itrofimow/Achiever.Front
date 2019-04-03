import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Redux/User/Draft/DraftActions.dart';

class MyProfileViewModel {
  final User user;

  final String newNickname;
  final String newAbout;
  final String newProfileImagePath;

  final Function update;
  final Function(String, String, String) updateDraft;

  MyProfileViewModel({
    this.user,
    this.newNickname,
    this.newAbout,
    this.newProfileImagePath,
    this.update,
    this.updateDraft
  });

  static MyProfileViewModel fromStore(Store<AppState> store) {
    final userState = store.state.userState;
    final draftState = store.state.draftState;

    return MyProfileViewModel(
      user: userState.user,
      newNickname: draftState.newNickname,
      newAbout: draftState.newAbout,
      newProfileImagePath: draftState.newProfileImagePath,
      update: () {
        store.dispatch(updateUser);
      },
      updateDraft: (
        String newNickname,
        String newAbout,
        String newProfileImagePah) {
        store.dispatch(UpdateDraftAction(
          newNickname,
          newAbout,
          newProfileImagePah));
      }
    );
  }
}

/*
Future _updateProfileImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile == null) return;

    final croppedFile = await ImageCropper.cropImage(
      ratioX: 1.0,
      ratioY: 1.0,
      sourcePath: imageFile.path,
      toolbarTitle: 'Cropper',
      toolbarColor: Colors.blue,
      circleShape: true
    );
    if (croppedFile == null) return;

    var newPath = '';//await _userApi.changeProfileImage(croppedFile);

    if (mounted) {
      setState(() {
              model.profileImagePath = newPath;
            });
    }*/