import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/exceptions/exceptions.dart';
import '../../../domain/dto/get_by_category_dto.dart';
import '../../../domain/entity/genres_entity.dart';

import '../../../domain/entity/movie_list_entity.dart';
import '../../../domain/usecase/get_by_category_case.dart';

part 'get_by_category_cubit.freezed.dart';
part 'get_by_category_state.dart';

@injectable
class GetByCategoryCubit extends Cubit<GetByCategoryState> {
  GetByCategoryCubit(this._useCase) : super(const GetByCategoryState.initial());

  final GetByCategoryCase _useCase;

  int _page = 1;
  int _totalPages = 0;
  bool _hasNextPage = true;
  bool _isLoadMore = false;
  List<ResultEntity> _tempMovieList = [];
  GenreDataEntity _tempGenre = GenreDataEntity();

  Future<void> fetchData(GenreDataEntity genre) async {
    emit(const GetByCategoryState.loading());

    _tempGenre = genre;
    final result = await _useCase.execute(
      GetByCategoryDto(
        page: _page,
        idCategory: _tempGenre.id ?? 0,
      ),
    );

    result.fold(
      (l) => emit(GetByCategoryState.failure(l)),
      (r) {
        _tempMovieList = r.results ?? [];
        _totalPages = r.totalPages ?? 0;
        _hasNextPage = _page < _totalPages;
        _page = r.page ?? 1;
        emit(GetByCategoryState.success(
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

    emit(GetByCategoryState.success(
      data: _tempMovieList,
      isLoadMore: _isLoadMore,
      hasNextPage: _hasNextPage,
    ));

    final result = await _useCase.execute(
      GetByCategoryDto(
        page: _page + 1,
        idCategory: _tempGenre.id ?? 0,
      ),
    );

    result.fold(
      (l) {
        _isLoadMore = false;
        emit(
          GetByCategoryState.failure(l),
        );
      },
      (r) {
        _page = r.page ?? 1;
        _totalPages = r.totalPages ?? 1;
        _hasNextPage = _page < _totalPages;
        _tempMovieList = UnmodifiableListView<ResultEntity>(
            (_tempMovieList) + (r.results ?? []));
        _isLoadMore = false;
        emit(GetByCategoryState.success(
          data: _tempMovieList,
          isLoadMore: _isLoadMore,
          hasNextPage: _hasNextPage,
        ));
      },
    );
  }
}
