part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;
  final int currentPage;

  const ProductLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax, currentPage];
}

class ProductFeaturedLoaded extends ProductState {
  final List<Product> featuredProducts;

  const ProductFeaturedLoaded({required this.featuredProducts});

  @override
  List<Object> get props => [featuredProducts];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
