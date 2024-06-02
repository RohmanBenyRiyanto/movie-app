import 'package:injectable/injectable.dart';

import '../../../../core/service/network/network.dart';
import '../model/search_movie_model.dart';

abstract class SearchSource {
  Future<SearchMovieModel> search({
    int? page,
    String? query,
  });
}

@LazySingleton(as: SearchSource)
class SearchSourceImpl implements SearchSource {
  SearchSourceImpl(this._apiClient);

  final ApiClient _apiClient;
  final ApiEndpoint _apiEndpoint = ApiEndpoint.latest;

  @override
  Future<SearchMovieModel> search({
    int? page,
    String? query,
  }) async {
    final response = await _apiClient.get(
      url: _apiEndpoint.search,
      params: {
        "page": page,
        "query": query,
      },
    );

    if (response != null) {
      return SearchMovieModel.fromJson(response);
    } else {
      return response;
    }
  }
}
