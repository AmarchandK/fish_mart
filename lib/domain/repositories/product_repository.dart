import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
  });
  
  Future<Either<Failure, List<Product>>> getFeaturedProducts();
  Future<Either<Failure, Product>> getProductById(String productId);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
}
