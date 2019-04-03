import 'package:achiever/AppContainer.dart';
import '../Models/Login/Login.dart';
import '../Models/User/UserWithToken.dart';
import '../Models/Login/Signup.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final _authApi = AppContainer.authApi;

  factory AuthService() {
    return _instance;
  }

  Future<UserWithToken> authenticate(Login loginModel) async {
    return await _authApi.authenticate(loginModel);
  }

  Future<UserWithToken> signup(Signup signupModel) async {
    return await _authApi.signup(signupModel);
  }

  AuthService._internal();
}