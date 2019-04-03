import 'package:achiever/BLLayer/ApiInterfaces/IAllUsersApi.dart';
import 'package:achiever/BLLayer/Models/User/UserDto.dart';
import 'package:achiever/BLLayer/Models/User/AllUsersDto.dart';
import '../ApiClient.dart';

class AllUsersApi implements IAllUsersApi {
  static final AllUsersApi _instance = AllUsersApi._internal();
  ApiClient _client;

  factory AllUsersApi() {
    return _instance;
  }

  Future<List<UserDto>> getAllUsers() async {
    final model = await _client.makeGet<AllUsersDto>(
      '/allUsers', 
      (json) => AllUsersDto.fromJson(json));

    return model.allUsers;
  }
  
  AllUsersApi._internal() {
    _client = new ApiClient();
  }
}