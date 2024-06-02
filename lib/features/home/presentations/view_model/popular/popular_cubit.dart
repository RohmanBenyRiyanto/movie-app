import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/exceptions/exceptions.dart';
import '../../../domain/entity/movie_list_entity.dart';
import '../../../domain/usecase/popular_case.dart';

part 'popular_cubit.freezed.dart';
part 'popular_state.dart';

@injectable
class PopularCubit extends Cubit<PopularState> {
  PopularCubit(this._popularCase) : super(const PopularState.initial());

  final PopularCase _popularCase;

  Future<void> refreshData() async => await fetchData();

  Future<void> fetchData() async {
    emit(const PopularState.loading());

    final result = await _popularCase.execute();

    result.fold(
      (l) => emit(PopularState.failure(l)),
      (r) => emit(PopularState.success(movies: r)),
    );
  }
}
