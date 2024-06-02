import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../entity/movie_list_entity.dart';

abstract class GetByCategoryRepo {
  Future<Either<Failure, MovieListEntity>> getMoviesByCategory({
    required int idCategory,
    required int page,
  });
}
