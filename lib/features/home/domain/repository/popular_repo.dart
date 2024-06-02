import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entity/movie_list_entity.dart';

abstract class PopularRepo {
  Future<Either<Failure, MovieListEntity>> getPopular();
}
