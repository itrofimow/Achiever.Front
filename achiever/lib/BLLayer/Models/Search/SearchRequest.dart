import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'SearchRequest.g.dart';

@JsonSerializable()
class SearchRequest extends AchieverJsonable with _$SearchRequestSerializerMixin {
  final String query;

  SearchRequest(this.query);

  factory SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);
}