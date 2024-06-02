import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie/core/exceptions/failure.dart';
import 'package:movie/core/usecase/use_case.dart';

import '../dto/search_dto.dart';
import '../entity/search_movie_entity.dart';
import '../repository/search_repo.dart';

@lazySingleton
class SearchCase implements UseCase<SearchMovieEntity, SearchDto> {
  SearchCase(this._repository);

  final SearchRepo _repository;

  @override
  Future<Either<Failure, SearchMovieEntity>> execute(SearchDto params) async {
    return await _repository.search(
      page: params.page,
      query: params.query,
    );
  }
}
