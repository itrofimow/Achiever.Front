import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'ChangeProfileImageRequest.g.dart';

@JsonSerializable()
class ChangeProfileImageRequest extends AchieverJsonable with _$ChangeProfileImageRequestSerializerMixin {
  final String profileImagePath;

  ChangeProfileImageRequest(this.profileImagePath);

  factory ChangeProfileImageRequest.fromJson(Map<String, dynamic> json) => _$ChangeProfileImageRequestFromJson(json);
}