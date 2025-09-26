part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Product> featuredProducts;
  final List<String> bannerImages;

  const HomeLoaded({
    required this.categories,
    required this.featuredProducts,
    required this.bannerImages,
  });

  @override
  List<Object> get props => [categories, featuredProducts, bannerImages];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
