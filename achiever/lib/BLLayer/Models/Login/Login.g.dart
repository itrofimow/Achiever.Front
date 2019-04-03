// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return new Login(json['name'] as String, json['password'] as String,
      json['firebaseToken'] as String);
}

abstract class _$LoginSerializerMixin {
  String get name;
  String get password;
  String get firebaseToken;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'password': password,
        'firebaseToken': firebaseToken
      };
}
