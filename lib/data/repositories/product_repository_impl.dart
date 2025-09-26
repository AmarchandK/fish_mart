import '../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        page: page,
        limit: limit,
        categoryId: categoryId,
        searchQuery: searchQuery,
      );
      return products;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getFeaturedProducts() async {
    try {
      final products = await remoteDataSource.getFeaturedProducts();
      return products;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Product> getProductById(String productId) async {
    try {
      final product = await remoteDataSource.getProductById(productId);
      return product;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final products =
          await remoteDataSource.getProducts(categoryId: categoryId);
      return products;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final products = await remoteDataSource.getProducts(searchQuery: query);
      return products;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
