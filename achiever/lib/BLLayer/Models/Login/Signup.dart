import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'Signup.g.dart';

@JsonSerializable()
class Signup extends AchieverJsonable with _$SignupSerializerMixin {
  String nickname;
  String password;
  String email;
  String firebaseToken;
  Signup(this.nickname, this.password, this.email, this.firebaseToken);

  factory Signup.fromJson(Map<String, dynamic> json) => _$SignupFromJson(json);
}