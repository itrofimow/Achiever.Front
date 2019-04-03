import 'package:json_annotation/json_annotation.dart';
import 'package:achiever/BLLayer/Models/AchieverJsonable.dart';
import './UserStats.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends AchieverJsonable with _$UserSerializerMixin {
  String id;
  String nickname;
  String profileImagePath;
  UserStats stats;
  String about;

  User({
    this.id,
    this.nickname, 
    this.profileImagePath, 
    this.stats, 
    this.about});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}