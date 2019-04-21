// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AcquiredAtDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcquiredAtDto _$AcquiredAtDtoFromJson(Map<String, dynamic> json) {
  return new AcquiredAtDto(json['value'] as bool, json['when'] as String);
}

abstract class _$AcquiredAtDtoSerializerMixin {
  bool get value;
  String get when;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'value': value, 'when': when};
}
