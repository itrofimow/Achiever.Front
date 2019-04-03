import '../Models/Login/Login.dart';
import '../Models/Login/Signup.dart';
import '../Models/User/UserWithToken.dart';

abstract class IAuthApi {
  Future<UserWithToken> authenticate(Login loginModel);

  Future<UserWithToken> signup(Signup signupModel);
}