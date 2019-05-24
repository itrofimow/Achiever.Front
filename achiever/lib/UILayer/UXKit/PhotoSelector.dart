
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'dart:io';

class PhotoSelector {
  static Future<File> selectPhoto(BuildContext context, 
  {
    bool applyCropper = true,
    bool allowCamera = false
  }) async {
    if (!allowCamera) return _selectPhotoInner(ImageSource.gallery, applyCropper);

    return await showModalBottomSheet(
      context: context, 
      builder: (bc) => _buildSourceSelectorWidget(bc, applyCropper));
  }

  static Future<File> _selectPhotoInner(ImageSource source, bool applyCropper) async {
    final image = await ImagePicker.pickImage(source: source);

    if (image == null) return null;

    if (!applyCropper) return image;

    return await ImageCropper.cropImage(sourcePath: image.path);
  }

  static Widget _buildSourceSelectorWidget(BuildContext context, bool applyCropper) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      letterSpacing: 0.22,
      color: Color.fromRGBO(52, 52, 52, 1)
    );

    return SafeArea(
      child: Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Image.asset('assets/photo_selector_photo.png', width: 36, height: 36,),
              title: Text('Сделать фотографию', style: style),
              onTap: () async {
                final image = await _selectPhotoInner(ImageSource.camera, applyCropper);
                Navigator.pop(context, image);
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              height: 1,
              color: Color.fromRGBO(0, 0, 0, 0.2),
            ),
            ListTile(
              leading: Image.asset('assets/photo_selector_gallery.png', width: 36, height: 36,),
              title: Text('Выбрать из галереи', style: style),
              onTap: () async {
                final image = await _selectPhotoInner(ImageSource.gallery, applyCropper);
                Navigator.pop(context, image);
              },
            )
          ]
        ),
      )
    );
  }

  /*Future<File> _selectPhoto({
    bool applyCropper
  }) async {
    //final test = await PhotoSelector.selectPhoto();

    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    final croppedImage = await ImageCropper.cropImage(sourcePath: image.path);

    return croppedImage;
  }*/
}