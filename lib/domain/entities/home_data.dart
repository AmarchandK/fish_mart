import 'package:equatable/equatable.dart';

import 'category.dart';
import 'product.dart';

class HomeData extends Equatable {
  final List<Category> categories;
  final List<Product> featuredProducts;
  final List<String> bannerImages;

  const HomeData({
    required this.categories,
    required this.featuredProducts,
    required this.bannerImages,
  });

  @override
  List<Object> get props => [categories, featuredProducts, bannerImages];
}
