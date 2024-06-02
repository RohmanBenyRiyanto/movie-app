import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/movie_list_entity.dart';
import '../repository/popular_repo.dart';

@lazySingleton
class PopularCase implements NoParamUseCase<MovieListEntity> {
  PopularCase(this._nowPlayingRepo);

  final PopularRepo _nowPlayingRepo;

  @override
  Future<Either<Failure, MovieListEntity>> execute() async {
    return await _nowPlayingRepo.getPopular();
  }
}
