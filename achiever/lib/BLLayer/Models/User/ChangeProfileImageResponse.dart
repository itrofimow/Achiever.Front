import 'package:json_annotation/json_annotation.dart';

part 'ChangeProfileImageResponse.g.dart';

@JsonSerializable()
class ChangeProfileImageResponse extends Object with _$ChangeProfileImageResponseSerializerMixin {
  final String path;

  ChangeProfileImageResponse(this.path);

  factory ChangeProfileImageResponse.fromJson(Map<String, dynamic> json) => _$ChangeProfileImageResponseFromJson(json);
}