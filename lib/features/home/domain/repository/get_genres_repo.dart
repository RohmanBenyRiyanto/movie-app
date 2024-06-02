import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../data/model/genres_model.dart';

abstract class GetGenresRepo {
  Future<Either<Failure, GenreModel>> getGenres();
}
