import 'package:json_annotation/json_annotation.dart';
import 'UserDto.dart';

part 'AllUsersDto.g.dart';

@JsonSerializable()
class AllUsersDto extends Object with _$AllUsersDtoSerializerMixin {
  final List<UserDto> allUsers;

  AllUsersDto(this.allUsers);

  factory AllUsersDto.fromJson(Map<String, dynamic> json) => _$AllUsersDtoFromJson(json);
}