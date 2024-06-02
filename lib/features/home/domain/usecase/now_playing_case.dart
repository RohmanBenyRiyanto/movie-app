import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/movie_list_entity.dart';
import '../repository/now_playing_repo.dart';

@lazySingleton
class NowPlayingCase implements UseCase<MovieListEntity, int> {
  NowPlayingCase(this._nowPlayingRepo);

  final NowPlayingRepo _nowPlayingRepo;

  @override
  Future<Either<Failure, MovieListEntity>> execute(int page) async {
    return await _nowPlayingRepo.getNowPlaying(page: page);
  }
}
