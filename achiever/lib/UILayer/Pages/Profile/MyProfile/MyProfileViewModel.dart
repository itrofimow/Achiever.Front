import 'package:redux/redux.dart';
import 'package:achiever/BLLayer/Redux/AppState.dart';
import 'package:achiever/BLLayer/Models/User/User.dart';
import 'package:achiever/BLLayer/Redux/User/UserActions.dart';
import 'package:achiever/BLLayer/Redux/User/Draft/DraftActions.dart';
import '../../PersonalFeed/PersonalFeedViewModel.dart';

import 'package:achiever/BLLayer/Models/User/UserDto.dart';

class MyProfileViewModel {
  final User user;

  final String newNickname;
  final String newAbout;
  final String newProfileImagePath;

  final Function update;
  final Function(String, String, String) updateDraft;
  final Function resetPersonalFeed;

  final List<UserDto> followers;
  final List<UserDto> followings;

  MyProfileViewModel({
    this.user,
    this.newNickname,
    this.newAbout,
    this.newProfileImagePath,
    this.update,
    this.updateDraft,
    this.resetPersonalFeed,

    this.followers,
    this.followings
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
      },
      resetPersonalFeed: () {
        final personalFeedViewModel = PersonalFeedViewModel.fromStore(store, userState.user.id, false);
        personalFeedViewModel.resetFeed();
        return personalFeedViewModel.loadMore();
      },

      followers: userState.followers.map((x) => userState.knownUsers[x]).toList(),
      followings: userState.followings.map((x) => userState.knownUsers[x]).toList()
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