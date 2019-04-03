// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ErrorResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return new ErrorResponse(json['message'] as String);
}

abstract class _$ErrorResponseSerializerMixin {
  String get message;
  Map<String, dynamic> toJson() => <String, dynamic>{'message': message};
}
