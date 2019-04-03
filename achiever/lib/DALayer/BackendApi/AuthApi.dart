import 'package:achiever/BLLayer/ApiInterfaces/IAuthApi.dart';
import '../ApiClient.dart';

import 'package:achiever/BLLayer/Models/Login/Login.dart';
import 'package:achiever/BLLayer/Models/Login/Signup.dart';
import 'package:achiever/BLLayer/Models/User/UserWithToken.dart';

class AuthApi implements IAuthApi {
  static final AuthApi _instance = AuthApi._internal();
  ApiClient _client;

  factory AuthApi() {
    return _instance;
  }

  Future<UserWithToken> authenticate(Login loginModel) async {
    final response = await _client.makePostResponse<UserWithToken, Login>('/user/authenticate', loginModel, 
      (json) => UserWithToken.fromJson(json));

    _client.setToken(response.token);

    return response;
  }

  Future<UserWithToken> signup(Signup signupModel) async {
    final response = await _client.makePostResponse<UserWithToken, Signup>('/user/signup', signupModel,
      (json) => UserWithToken.fromJson(json));

    _client.setToken(response.token);

    return response;
  }

  AuthApi._internal() {
    _client = new ApiClient();
  }
}