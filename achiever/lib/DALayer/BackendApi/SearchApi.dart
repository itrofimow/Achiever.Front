import 'package:achiever/BLLayer/ApiInterfaces/ISearchApi.dart';
import 'package:achiever/BLLayer/Models/Search/SearchRequest.dart';
import 'package:achiever/BLLayer/Models/Search/SearchResult.dart';
import '../ApiClient.dart';

class SearchApi extends ISearchApi {
  static final SearchApi _instance = SearchApi._internal();
  ApiClient _client;

  factory SearchApi() {
    return _instance;
  }

  Future<SearchResult> search(SearchRequest request) async {
    final response = await _client.makePostResponse<SearchResult, SearchRequest>(
      '/search', request, 
      (json) => SearchResult.fromJson(json));

    return response;
  }

  SearchApi._internal() {
    _client = new ApiClient();
  }
}