/*import 'package:achiever/ApiInterfaces/IBackendApi.dart';
import 'package:achiever/Models/Feed/FeedEntryResponse.dart';
import 'package:achiever/Models/Login/Login.dart';
import 'package:achiever/Models/Login/Signup.dart';
import 'package:achiever/Models/User/User.dart';
import 'package:achiever/Models/Login/Token.dart';
import 'package:achiever/Models/User/ChangeProfileImageRequest.dart';
import 'package:achiever/Models/Achievement/AllAchievementsResponse.dart';
import 'package:achiever/Models/Achievement/Achievement.dart';
import 'package:achiever/Models/Feed/CreateEntryByAchievementRequest.dart';
import 'package:http/http.dart' as http;
import './ErrorResponse.dart';
import 'package:achiever/Models/AchieverJsonable.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class BackendApi implements IBackendApi {
	static final BackendApi _singleton = new BackendApi._internal();
	static final JsonEncoder _encoder = new JsonEncoder();

  String _token;
	
  static final String _backendUrl = "http://172.31.136.56:1337";

	static final String _apiUrl = _backendUrl + '/api';
  static final String staticUrl = _backendUrl + "/images";

	factory BackendApi() {
		return _singleton;
	}

  Future uploadImage(File imageFile) async {
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(_apiUrl + '/upload');
    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var response = await request.send();

    var c = response.statusCode;
  }

  Future changeProfileImage(ChangeProfileImageRequest request) async {
    await makePostRequestNoresponse(_apiUrl + '/user/current/profileImage', request);
  }

	Future<String> authenticate(Login loginModel) async {
    final token = await makePostRequest<Token, Login>(_apiUrl + '/user/authenticate', loginModel, 
      (json) => Token.fromJson(json));

    _token = token.token;	
		return _token;
	}

  Future signup(Signup signupModel) async {
    return makePostRequestNoresponse(_apiUrl + '/user/signup', signupModel);
  }

	Future<FeedEntryResponse> getFeedEntry(int index) async {
    return makeGetRequest<FeedEntryResponse>(_apiUrl + '/feed/one/$index', 
      (json) => FeedEntryResponse.fromJson(json));
	}

  Future<FeedEntryResponse> getMyFeedEntry(int index) async {
    return makeGetRequest<FeedEntryResponse>(_apiUrl + '/feed/myone/$index', 
      (json) => FeedEntryResponse.fromJson(json));
  }

  Future<User> getCurrentUser() async {
    return await makeGetRequest<User>(_apiUrl + '/user/current', 
      (json) => User.fromJsom(json));
  }

  Future<User> getUserById(String id) async {
    return await makeGetRequest<User>(_apiUrl + '/user/$id',
      (json) => User.fromJsom(json));
  }

  Future<List<Achievement>> getAllAchievements() async {
    final response = await makeGetRequest<AllAchievementsResponse>(_apiUrl + '/achievement/all', 
      (json) => AllAchievementsResponse.fromJson(json));

    return response.achievements;
  }

  Future<Achievement> getById(String id) async {
    return makeGetRequest<Achievement>(_apiUrl + '/achievement/id/$id', 
      (json) => Achievement.fromJson(json));
  }

  Future createFeedEntryByAchievement(CreateEntryByAchievementRequest model, List<File> images) async {
    var uri = Uri.parse(_apiUrl + '/feed');
    var request = new http.MultipartRequest("POST", uri);

    await Future.forEach(images, (file) async {
      await _addFileToRequest(request, file);
    });

    model.toJson().forEach((key, value){
      request.fields[key] = value as String;
    });
    request.headers['Authorization'] = 'Bearer $_token';
    //request.headers.addAll(getHeaders());

    var response = await request.send();
    var a = 1;
  }

  Future createAchievement(Achievement model, File backgroundImage, File foregroundImage) async {
    var uri = Uri.parse(_apiUrl + '/achievement');
    var request = new http.MultipartRequest("POST", uri);

    await _addFileToRequest(request, backgroundImage);
    await _addFileToRequest(request, foregroundImage);

    request.fields['title'] = model.title;
    request.fields['description'] = model.description;

    await request.send();
  }

  Future _addFileToRequest(http.MultipartRequest request, File file) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var multipartFile = new http.MultipartFile('files', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
  }

	static String toJson(Map<String, dynamic> json) {
		return _encoder.convert(json);
	}

  Map<String, String> getHeaders() {
    return {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $_token'
    };
  }

  Future<T> makePostRequest<T, TV extends AchieverJsonable>(String url, TV object,
    Function toModel) async {
    final json = toJson(object.toJson());
    final headers = getHeaders();

    final response = await http.post(url, headers: headers, body: json);

    if (response.statusCode != 200) {
      final error = ErrorResponse.fromJson(fromJson(response.body));
      throw new Exception(error.message);
    }

    return toModel(fromJson(response.body)) as T;
  }

  Future makePostRequestNoresponse<TV extends AchieverJsonable>(String url, TV object) async {
    final json = toJson(object.toJson());
    final headers = getHeaders();

    final response = await http.post(url, headers: headers, body: json);

    if (response.statusCode != 200) {
      final error = ErrorResponse.fromJson(fromJson(response.body));
      throw new Exception(error.message);
    }
  }

  Future<T> makeGetRequest<T>(String url, Function toModel) async {
    final headers = getHeaders();

    final response = await http.get(url, headers: headers);

    if (response.statusCode != 200) {
      final error = ErrorResponse.fromJson(fromJson(response.body));
      throw new Exception(error.message);
    }

    return toModel(fromJson(response.body)) as T;
  }

	static Map<String, dynamic> fromJson(String value) {
		return json.decode(value);
	}

	BackendApi._internal();
}*/