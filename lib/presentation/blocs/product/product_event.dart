part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductLoadRequested extends ProductEvent {
  final int page;
  final int limit;
  final String? categoryId;
  final String? searchQuery;

  const ProductLoadRequested({
    this.page = 1,
    this.limit = 20,
    this.categoryId,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [page, limit, categoryId, searchQuery];
}

class ProductFeaturedLoadRequested extends ProductEvent {
  const ProductFeaturedLoadRequested();
}

class ProductRefreshRequested extends ProductEvent {
  const ProductRefreshRequested();
}
