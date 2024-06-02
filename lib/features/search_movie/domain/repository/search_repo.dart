import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../entity/search_movie_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchMovieEntity>> search({
    int? page,
    String? query,
  });
}
