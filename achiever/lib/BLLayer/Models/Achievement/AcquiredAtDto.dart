import 'package:json_annotation/json_annotation.dart';

part 'AcquiredAtDto.g.dart';

@JsonSerializable()
class AcquiredAtDto extends Object with _$AcquiredAtDtoSerializerMixin {
  final bool value;
  final String when;

  AcquiredAtDto(this.value, this.when);

  factory AcquiredAtDto.fromJson(Map<String, dynamic> json) => _$AcquiredAtDtoFromJson(json);
}