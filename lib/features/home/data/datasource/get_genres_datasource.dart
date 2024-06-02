import 'package:injectable/injectable.dart';

import '../../../../core/service/network/network.dart';
import '../model/genres_model.dart';

abstract class GetGenresDatasource {
  Future<GenreModel> getGenres();
}

@LazySingleton(as: GetGenresDatasource)
class GetGenresDatasourceImpl implements GetGenresDatasource {
  GetGenresDatasourceImpl(this._client);

  final ApiClient _client;
  final ApiEndpoint _endpoint = ApiEndpoint.latest;

  @override
  Future<GenreModel> getGenres() async {
    final response = await _client.get(
      url: _endpoint.genres,
    );

    if (response != null) {
      return GenreModel.fromJson(response);
    } else {
      return response;
    }
  }
}
