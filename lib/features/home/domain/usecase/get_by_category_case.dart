import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/usecase/use_case.dart';
import '../dto/get_by_category_dto.dart';
import '../entity/movie_list_entity.dart';
import '../repository/get_by_category_repo.dart';

@lazySingleton
class GetByCategoryCase implements UseCase<MovieListEntity, GetByCategoryDto> {
  GetByCategoryCase(this._getByCategoryRepo);

  final GetByCategoryRepo _getByCategoryRepo;

  @override
  Future<Either<Failure, MovieListEntity>> execute(
      GetByCategoryDto params) async {
    return await _getByCategoryRepo.getMoviesByCategory(
      idCategory: params.idCategory,
      page: params.page,
    );
  }
}
