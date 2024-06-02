import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/now_playing_repo.dart';
import '../datasource/now_playing_source.dart';

@LazySingleton(as: NowPlayingRepo)
class NowPlayingRepoImpl implements NowPlayingRepo {
  NowPlayingRepoImpl(this._remoteDataSource, this._exception);

  final NowPlayingSource _remoteDataSource;
  final ResponseException _exception;

  @override
  Future<Either<Failure, MovieListEntity>> getNowPlaying({
    required int page,
  }) async {
    return _exception.exc<MovieListEntity>(
      () async => await _remoteDataSource.getNowPlaying(page: page),
    );
  }
}
