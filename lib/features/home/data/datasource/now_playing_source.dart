import 'package:injectable/injectable.dart';

import '../../../../core/service/network/network.dart';
import '../model/movie_list_model.dart';

abstract class NowPlayingSource {
  Future<MovieListModel> getNowPlaying({required int page});
}

@LazySingleton(as: NowPlayingSource)
class NowPlayingSourceImpl implements NowPlayingSource {
  NowPlayingSourceImpl(this._client);

  final ApiClient _client;
  final ApiEndpoint _endpoint = ApiEndpoint.latest;

  @override
  Future<MovieListModel> getNowPlaying({required int page}) async {
    final response = await _client.get(
      url: _endpoint.nowPlaying,
      params: {"page": page},
    );

    if (response != null) {
      return MovieListModel.fromJson(response);
    } else {
      return response;
    }
  }
}
