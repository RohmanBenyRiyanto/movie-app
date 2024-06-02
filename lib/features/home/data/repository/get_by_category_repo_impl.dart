import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entity/movie_list_entity.dart';
import '../../domain/repository/get_by_category_repo.dart';
import '../datasource/get_by_category_source.dart';

@LazySingleton(as: GetByCategoryRepo)
class GetByCategoryRepoImpl implements GetByCategoryRepo {
  GetByCategoryRepoImpl(this._remoteDataSource, this._exception);

  final GetByCategorySource _remoteDataSource;
  final ResponseException _exception;

  @override
  Future<Either<Failure, MovieListEntity>> getMoviesByCategory({
    required int idCategory,
    required int page,
  }) async {
    return _exception.exc<MovieListEntity>(
      () async => await _remoteDataSource.getMoviesByCategory(
        idCategory: idCategory,
        page: page,
      ),
    );
  }
}
