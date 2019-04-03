// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signup _$SignupFromJson(Map<String, dynamic> json) {
  return new Signup(json['nickname'] as String, json['password'] as String,
      json['email'] as String, json['firebaseToken'] as String);
}

abstract class _$SignupSerializerMixin {
  String get nickname;
  String get password;
  String get email;
  String get firebaseToken;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickname': nickname,
        'password': password,
        'email': email,
        'firebaseToken': firebaseToken
      };
}
