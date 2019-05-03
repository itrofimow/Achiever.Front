import 'package:dio/dio.dart';

import 'package:achiever/BLLayer/Models/AchieverJsonable.dart';

class ApiClient {
  static final ApiClient _instance = new ApiClient._internal();

  static const String baseUrl = 'http://192.168.0.16:1337/';//'https://achiever.gg/';//'http://192.168.43.192:1337/';
  static final String staticUrl = baseUrl + 'images';

  Dio _client;
  
  String _token;

  factory ApiClient() {
    return _instance;
  }

  setToken(String token) {
    _token = token;
  }

  Future<T> makeGet<T>(String url, Function toModel, 
    {Map<String, String> params}) async {

    final response = await _client.get(url, data: params);

    return toModel(response.data);
  }

  Future makePost<T extends AchieverJsonable>(String url, T model) async {
    final data = model.toJson();

    await _client.post(url, data: data);
  }

  Future makePutNoModel(String url) async {
    await _client.put(url);
  }

  Future makePut<T extends AchieverJsonable>(String url, T model) async {
    final data = model.toJson();

    await _client.put(url, data: data);
  }

  Future<T> makePutResponse<T, TV extends AchieverJsonable>(String url, TV model, Function toModel) async {
    final data = model.toJson();

    final response = await _client.put(url, data: data);

    return toModel(response.data);
  }

  Future makeDelete<T extends AchieverJsonable>(String url, T model) async {
    final data = model.toJson();

    await _client.delete(url, data: data);
  }

  Future<T> makePostResponse<T, TV extends AchieverJsonable>(String url, TV model, Function toModel) async {
    final data = model.toJson();

    final response = await _client.post(url, data: data);

    return toModel(response.data);
  }

  Future postFormData(String url, FormData data) async {
    await _client.post(url, data: data);
  }

  Future<T> postFormDataResponse<T>(String url, FormData data, Function toModel) async {
    final response = await _client.post(url, data: data);

    return toModel(response.data);
  }

  ApiClient._internal() {
    final options = Options(
      baseUrl: baseUrl + 'api',
    );

    _client = Dio(options)..onHttpClientCreate = (client) {
      client.idleTimeout = Duration(minutes: 10);
    };

    _client.interceptor.request.onSend = (Options options) {
      if (_token != null) {
        options.headers['Authorization'] = 'Bearer $_token';
      }

      return options;
    };

    _client.interceptor.response.onError = (DioError e) {
      return e;
    };
  }
}
