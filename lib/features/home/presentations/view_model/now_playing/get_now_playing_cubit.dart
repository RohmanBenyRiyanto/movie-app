import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../../domain/entity/movie_list_entity.dart';
import '../../../domain/usecase/now_playing_case.dart';

part 'get_now_playing_cubit.freezed.dart';
part 'get_now_playing_state.dart';

@injectable
class GetNowPlayingCubit extends Cubit<GetNowPlayingState> {
  final NowPlayingCase _nowPlayingCase;

  GetNowPlayingCubit(this._nowPlayingCase)
      : super(const GetNowPlayingState.initial());

  int _page = 1;
  int _totalPages = 0;
  bool _hasNextPage = true;
  bool _isLoadMore = false;
  List<ResultEntity> _tempMovieList = [];

  Future<void> fetchData() async {
    emit(const GetNowPlayingState.loading());

    final result = await _nowPlayingCase.execute(_page);

    result.fold(
      (l) => emit(GetNowPlayingState.failure(l)),
      (r) {
        _tempMovieList = r.results ?? [];
        _totalPages = r.totalPages ?? 0;
        _hasNextPage = _page < _totalPages;
        _page = r.page ?? 1;
        emit(GetNowPlayingState.success(
          data: _tempMovieList,
          isLoadMore: _isLoadMore,
          hasNextPage: _hasNextPage,
        ));
      },
    );
  }

  Future<void> fetchMoreData() async {
    if (!_hasNextPage || _isLoadMore) return;
    _isLoadMore = true;

    // emit(GetNowPlayingState.success);
    final result = await _nowPlayingCase.execute(_page + 1);

    result.fold(
      (l) {
        _isLoadMore = false;
        emit(
          GetNowPlayingState.failure(l),
        );
      },
      (r) {
        _page = r.page ?? 1;
        _totalPages = r.totalPages ?? 1;
        _hasNextPage = _page < _totalPages;
        _tempMovieList = UnmodifiableListView<ResultEntity>(
            (_tempMovieList) + (r.results ?? []));
        _isLoadMore = false;
        emit(GetNowPlayingState.success(
          data: _tempMovieList,
          isLoadMore: _isLoadMore,
          hasNextPage: _hasNextPage,
        ));
      },
    );
  }
}
