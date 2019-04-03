import '../Models/User/UserDto.dart';

abstract class IAllUsersApi {
  Future<List<UserDto>> getAllUsers();
}