import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/genres_entity.dart';
import '../repository/get_genres_repo.dart';

@lazySingleton
class GetGenresCase implements NoParamUseCase<GenreEntity> {
  GetGenresCase(this._getGenresRepo);

  final GetGenresRepo _getGenresRepo;

  @override
  Future<Either<Failure, GenreEntity>> execute() async {
    return await _getGenresRepo.getGenres();
  }
}
