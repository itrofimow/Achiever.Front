import 'package:json_annotation/json_annotation.dart';

part 'ImageInfo.g.dart';

@JsonSerializable()
class ImageInfo extends Object with _$ImageInfoSerializerMixin {
  final String imagePath;
  final int width;
  final int height;

  ImageInfo(this.imagePath, this.width, this.height);

  factory ImageInfo.fromJson(Map<String, dynamic> json) => _$ImageInfoFromJson(json);
}