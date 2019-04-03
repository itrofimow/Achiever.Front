import '../Models/Search/SearchRequest.dart';
import '../Models/Search/SearchResult.dart';

abstract class ISearchApi {
  Future<SearchResult> search(SearchRequest request);
}