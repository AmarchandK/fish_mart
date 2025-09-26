import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/product/get_products.dart';
import '../../../domain/usecases/product/get_featured_products.dart';
import '../../../core/usecase/usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetFeaturedProducts getFeaturedProducts;

  ProductBloc({
    required this.getProducts,
    required this.getFeaturedProducts,
  }) : super(const ProductInitial()) {
    on<ProductLoadRequested>(_onProductLoadRequested);
    on<ProductFeaturedLoadRequested>(_onProductFeaturedLoadRequested);
    on<ProductRefreshRequested>(_onProductRefreshRequested);
  }

  Future<void> _onProductLoadRequested(
    ProductLoadRequested event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductInitial) {
      emit(const ProductLoading());
    }

    try {
      final products = await getProducts(
        GetProductsParams(
          page: event.page,
          limit: event.limit,
          categoryId: event.categoryId,
          searchQuery: event.searchQuery,
        ),
      );

      if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;
        final allProducts = event.page == 1
            ? products
            : [...currentState.products, ...products];

        emit(ProductLoaded(
          products: allProducts,
          hasReachedMax: products.length < event.limit,
          currentPage: event.page,
        ));
      } else {
        emit(ProductLoaded(
          products: products,
          hasReachedMax: products.length < event.limit,
          currentPage: event.page,
        ));
      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onProductFeaturedLoadRequested(
    ProductFeaturedLoadRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    try {
      final products = await getFeaturedProducts(NoParams());
      emit(ProductFeaturedLoaded(featuredProducts: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  Future<void> _onProductRefreshRequested(
    ProductRefreshRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductInitial());
    add(const ProductLoadRequested(page: 1));
  }
}
