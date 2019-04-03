import 'package:json_annotation/json_annotation.dart';
import 'User.dart';

part 'UserDto.g.dart';

@JsonSerializable()
class UserDto extends Object with _$UserDtoSerializerMixin {
  final User user;
  final bool following;

  UserDto(this.user, this.following);

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}