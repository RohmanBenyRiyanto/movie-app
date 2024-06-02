import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/features/search_movie/domain/entity/search_movie_entity.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/repository/search_repo.dart';
import '../datasource/search_source.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  SearchRepoImpl(this._searchSource, this._exception);

  final SearchSource _searchSource;
  final ResponseException _exception;

  @override
  Future<Either<Failure, SearchMovieEntity>> search({
    int? page,
    String? query,
  }) async {
    return _exception.exc<SearchMovieEntity>(
      () async => await _searchSource.search(
        page: page,
        query: query,
      ),
    );
  }
}
