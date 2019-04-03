import 'package:json_annotation/json_annotation.dart';
import '../AchieverJsonable.dart';

part 'Login.g.dart';

@JsonSerializable()
class Login extends AchieverJsonable with _$LoginSerializerMixin {
	final String name;
	final String password;
  final String firebaseToken;
	Login(this.name, this.password, this.firebaseToken);

	factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}