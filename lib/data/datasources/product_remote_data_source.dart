import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
  });
  Future<List<ProductModel>> getFeaturedProducts();
  Future<ProductModel> getProductById(String productId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? searchQuery,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (searchQuery != null) queryParams['search'] = searchQuery;

      // Sample API call - replace with real endpoint
      final response = await client.get(
        '/products',
        queryParameters: queryParams,
      );

      if (response.containsKey('success') && response['success'] == true) {
        final products = (response['data']['products'] as List)
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        // Return demo products
        return _getDemoProducts();
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to fetch products: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.get('/products/featured');

      if (response.containsKey('success') && response['success'] == true) {
        final products = (response['data']['products'] as List)
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        // Return demo featured products
        return _getDemoProducts().take(4).toList();
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to fetch featured products: ${e.toString()}');
    }
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.get('/products/$productId');

      if (response.containsKey('success') && response['success'] == true) {
        return ProductModel.fromJson(
            response['data']['product'] as Map<String, dynamic>);
      } else {
        // Return demo product
        return _getDemoProducts().firstWhere(
          (product) => product.id == productId,
          orElse: () => _getDemoProducts().first,
        );
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to fetch product: ${e.toString()}');
    }
  }

  List<ProductModel> _getDemoProducts() {
    final now = DateTime.now();
    return [
      ProductModel(
        id: '1',
        name: 'Fresh Salmon',
        description: 'Premium quality Atlantic salmon',
        price: 299.99,
        originalPrice: 399.99,
        categoryId: '1',
        categoryName: 'Sea Fish',
        images: const [
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300'
        ],
        rating: 4.5,
        reviewCount: 120,
        isAvailable: true,
        unit: 'kg',
        weight: 1.0,
        nutritionalInfo: const {'protein': '25g', 'fat': '12g'},
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '2',
        name: 'King Fish',
        description: 'Fresh king fish from coastal waters',
        price: 249.99,
        originalPrice: null,
        categoryId: '1',
        categoryName: 'Sea Fish',
        images: const [
          'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300'
        ],
        rating: 4.8,
        reviewCount: 85,
        isAvailable: true,
        unit: 'kg',
        weight: 1.5,
        nutritionalInfo: const {'protein': '22g', 'fat': '8g'},
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '3',
        name: 'Fresh Prawns',
        description: 'Large tiger prawns',
        price: 399.99,
        originalPrice: 499.99,
        categoryId: '2',
        categoryName: 'Boat Fish',
        images: const [
          'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300'
        ],
        rating: 4.6,
        reviewCount: 95,
        isAvailable: false,
        unit: 'kg',
        weight: 0.5,
        nutritionalInfo: const {'protein': '20g', 'fat': '2g'},
        createdAt: now,
        updatedAt: now,
      ),
      ProductModel(
        id: '4',
        name: 'Tuna Steaks',
        description: 'Premium yellowfin tuna steaks',
        price: 199.99,
        originalPrice: null,
        categoryId: '1',
        categoryName: 'Sea Fish',
        images: const [
          'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300'
        ],
        rating: 4.3,
        reviewCount: 67,
        isAvailable: true,
        unit: 'piece',
        weight: 0.3,
        nutritionalInfo: const {'protein': '30g', 'fat': '5g'},
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}
