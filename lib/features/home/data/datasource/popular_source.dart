import 'package:injectable/injectable.dart';

import '../../../../core/service/network/network.dart';
import '../model/movie_list_model.dart';

abstract class PopularSource {
  Future<MovieListModel> getPopular();
}

@LazySingleton(as: PopularSource)
class PopularSourceImpl implements PopularSource {
  PopularSourceImpl(this._client);

  final ApiClient _client;
  final ApiEndpoint _endpoint = ApiEndpoint.latest;

  @override
  Future<MovieListModel> getPopular() async {
    final response = await _client.get(
      url: _endpoint.popularMovie("day"),
      params: {"page": 1},
    );

    if (response != null) {
      return MovieListModel.fromJson(response);
    } else {
      return response;
    }
  }
}
