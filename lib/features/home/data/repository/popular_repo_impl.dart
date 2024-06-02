import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/popular_repo.dart';
import '../datasource/popular_source.dart';

@LazySingleton(as: PopularRepo)
class PopularRepoImpl implements PopularRepo {
  PopularRepoImpl(this._remoteDataSource, this._exception);

  final PopularSource _remoteDataSource;
  final ResponseException _exception;

  @override
  Future<Either<Failure, MovieListEntity>> getPopular() async {
    return _exception.exc<MovieListEntity>(
      () async => await _remoteDataSource.getPopular(),
    );
  }
}
