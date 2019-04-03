import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static final SharedPrefsService _instance = SharedPrefsService._internal();

  factory SharedPrefsService() {
    return _instance;
  }

  static const String _aTokenKey = "_aTokenKey";

  Future<String> getToken() async {
    final prefs = await _getInstance();

    return prefs.getString(_aTokenKey);
  }

  Future setToken(String token) async {
    final prefs = await _getInstance();

    await prefs.setString(_aTokenKey, token);
  }

  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  SharedPrefsService._internal();
}