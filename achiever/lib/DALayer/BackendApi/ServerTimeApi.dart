import 'package:achiever/BLLayer/ApiInterfaces/IServerTimeApi.dart';
import '../ApiClient.dart';
import 'package:achiever/BLLayer/Models/ServerTime.dart';

class ServerTimeApi extends IServerTimeApi {
  static final ServerTimeApi _instance = ServerTimeApi._internal();
  ApiClient _client;

  factory ServerTimeApi() {
    return _instance;
  }

  Future<DateTime> now() async {
    final response = await _client.makeGet<ServerTime>(
      '/time',
      (json) => ServerTime.fromJson(json));

    return response.currentTime;
  }

  ServerTimeApi._internal() {
    _client = ApiClient();
  }
}