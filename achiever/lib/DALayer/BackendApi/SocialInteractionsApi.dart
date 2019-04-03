import 'package:achiever/BLLayer/ApiInterfaces/ISocialInteractionsApi.dart';
import 'package:achiever/BLLayer/Models/SocialInteractions/FollowUnfollowRequest.dart';
import '../ApiClient.dart';

class SocialInteractionsApi implements ISocialIntercationsApi {
  static final SocialInteractionsApi _instance = SocialInteractionsApi._internal();
  ApiClient _client;

  factory SocialInteractionsApi() {
    return _instance;
  }
  
  Future follow(String userId) async {
    final model = FollowUnfollowRequest(userId);

    await _client.makePut('/socialInteractions', model);
  }

  Future unfollow(String userId) async {
    final model = FollowUnfollowRequest(userId);

    await _client.makeDelete('/socialInteractions', model);
  }
  
  SocialInteractionsApi._internal() {
    _client = new ApiClient();
  }
}