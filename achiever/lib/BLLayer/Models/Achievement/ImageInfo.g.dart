// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) {
  return new ImageInfo(
      json['imagePath'] as String, json['width'] as int, json['height'] as int);
}

abstract class _$ImageInfoSerializerMixin {
  String get imagePath;
  int get width;
  int get height;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'imagePath': imagePath,
        'width': width,
        'height': height
      };
}
