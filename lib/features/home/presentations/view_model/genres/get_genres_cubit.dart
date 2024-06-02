import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../../domain/entity/genres_entity.dart';
import '../../../domain/usecase/get_genres_case.dart';

part 'get_genres_cubit.freezed.dart';
part 'get_genres_state.dart';

@injectable
class GetGenresCubit extends Cubit<GetGenresState> {
  GetGenresCubit(
    this._getGenresCase,
  ) : super(const GetGenresState.initial());

  final GetGenresCase _getGenresCase;

  Future<void> refreshData() async => await fetchData();

  Future<void> fetchData() async {
    emit(const GetGenresState.loading());

    final result = await _getGenresCase.execute();

    result.fold(
      (l) => emit(GetGenresState.failure(l)),
      (r) => emit(GetGenresState.success(genres: r)),
    );
  }
}
