import 'package:injectable/injectable.dart';

import '../../../../core/service/network/network.dart';
import '../model/movie_list_model.dart';

abstract class GetByCategorySource {
  Future<MovieListModel> getMoviesByCategory({
    required int idCategory,
    required int page,
  });
}

@LazySingleton(as: GetByCategorySource)
class GetByCategorySourceImpl implements GetByCategorySource {
  GetByCategorySourceImpl(this._client);

  final ApiClient _client;
  final ApiEndpoint _endpoint = ApiEndpoint.latest;

  @override
  Future<MovieListModel> getMoviesByCategory({
    required int idCategory,
    required int page,
  }) async {
    final response = await _client.get(
      url: _endpoint.discover,
      params: {
        "include_adult": false,
        "include_video": false,
        "sort_by": "popularity.desc",
        "with_genres": idCategory,
        "page": page,
      },
    );

    if (response != null) {
      return MovieListModel.fromJson(response);
    } else {
      return response;
    }
  }
}
