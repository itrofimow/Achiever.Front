import 'package:json_annotation/json_annotation.dart';
import '../Achievement/Achievement.dart';
import '../User/UserDto.dart';

part 'SearchResult.g.dart';

@JsonSerializable()
class SearchResult extends Object with _$SearchResultSerializerMixin {
  final List<Achievement> achievements;
  final List<UserDto> users;

  SearchResult(
    this.achievements,
    this.users
  );

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);
}