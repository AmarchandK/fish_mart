import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
  });

  Future<List<Product>> getFeaturedProducts();
  Future<Product> getProductById(String productId);
  Future<List<Product>> getProductsByCategory(String categoryId);
  Future<List<Product>> searchProducts(String query);
}
