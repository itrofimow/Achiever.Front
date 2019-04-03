import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'UserWithToken.g.dart';

@JsonSerializable()
class UserWithToken extends Object with _$UserWithTokenSerializerMixin {
  final String token;
  final User user;

  UserWithToken(this.token, this.user);

  factory UserWithToken.fromJson(Map<String, dynamic> json) => _$UserWithTokenFromJson(json);
}