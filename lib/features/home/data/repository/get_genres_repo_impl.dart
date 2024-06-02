import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../domain/repository/get_genres_repo.dart';
import '../datasource/get_genres_datasource.dart';
import '../model/genres_model.dart';

@LazySingleton(as: GetGenresRepo)
class GetGenresRepoImpl implements GetGenresRepo {
  GetGenresRepoImpl(this._remoteDataSource, this._exception);

  final GetGenresDatasource _remoteDataSource;
  final ResponseException _exception;

  @override
  Future<Either<Failure, GenreModel>> getGenres() async {
    return _exception.exc<GenreModel>(
      () async => await _remoteDataSource.getGenres(),
    );
  }
}
