import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/usecases/category/get_categories.dart';
import '../../../core/usecase/usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories getCategories;

  CategoryBloc({required this.getCategories}) : super(const CategoryInitial()) {
    on<CategoryLoadRequested>(_onCategoryLoadRequested);
    on<CategoryRefreshRequested>(_onCategoryRefreshRequested);
  }

  Future<void> _onCategoryLoadRequested(
    CategoryLoadRequested event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    final result = await getCategories(NoParams());

    result.fold(
      (failure) => emit(CategoryError(message: failure.message)),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }

  Future<void> _onCategoryRefreshRequested(
    CategoryRefreshRequested event,
    Emitter<CategoryState> emit,
  ) async {
    add(const CategoryLoadRequested());
  }
}
