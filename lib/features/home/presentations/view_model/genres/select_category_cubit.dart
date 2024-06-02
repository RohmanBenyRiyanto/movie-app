import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/genres_entity.dart';

part 'select_category_state.dart';
part 'select_category_cubit.freezed.dart';

@injectable
class SelectCategoryCubit extends Cubit<SelectCategoryState> {
  SelectCategoryCubit() : super(const SelectCategoryState.selected());

  void select(GenreDataEntity genre) {
    emit(SelectCategoryState.selected(selected: genre));
  }
}
