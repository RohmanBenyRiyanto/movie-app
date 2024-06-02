import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/dto/search_dto.dart';
import '../../domain/entity/search_movie_entity.dart';
import '../../domain/usecase/search_case.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._useCase) : super(const SearchState.initial());

  final SearchCase _useCase;

  int _page = 1;
  int _totalPages = 0;
  bool _hasNextPage = true;
  bool _isLoadMore = false;
  List<ResultEntity> _tempMovieList = [];
  String _tempQuery = '';

  Future<void> fetchData(String query) async {
    emit(const SearchState.loading());

    _tempQuery = query;
    final result = await _useCase.execute(
      SearchDto(
        page: _page,
        query: _tempQuery,
      ),
    );

    result.fold(
      (l) => emit(SearchState.failure(l)),
      (r) {
        _tempMovieList = r.results ?? [];
        _totalPages = r.totalPages ?? 0;
        _hasNextPage = _page < _totalPages;
        _page = r.page ?? 1;
        emit(SearchState.success(
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

    emit(
      SearchState.success(
        data: _tempMovieList,
        isLoadMore: _isLoadMore,
        hasNextPage: _hasNextPage,
      ),
    );
    final result = await _useCase.execute(
      SearchDto(
        page: _page + 1,
        query: _tempQuery,
      ),
    );

    result.fold(
      (l) {
        _isLoadMore = false;
        emit(
          SearchState.failure(l),
        );
      },
      (r) {
        _page = r.page ?? 1;
        _totalPages = r.totalPages ?? 1;
        _hasNextPage = _page < _totalPages;
        _tempMovieList = UnmodifiableListView<ResultEntity>(
            (_tempMovieList) + (r.results ?? []));
        _isLoadMore = false;
        emit(SearchState.success(
          data: _tempMovieList,
          isLoadMore: _isLoadMore,
          hasNextPage: _hasNextPage,
        ));
      },
    );
  }
}
