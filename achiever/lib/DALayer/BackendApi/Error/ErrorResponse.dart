import 'package:json_annotation/json_annotation.dart';

part 'ErrorResponse.g.dart';

@JsonSerializable()
class ErrorResponse extends Object with _$ErrorResponseSerializerMixin {
  final String message;

  ErrorResponse(this.message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}