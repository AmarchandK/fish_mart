import 'package:flutter_test/flutter_test.dart';
import 'package:fish_mart/domain/entities/product.dart';

void main() {
  group('Product Entity Tests', () {
    late Product testProduct;

    setUp(() {
      testProduct = Product(
        id: '1',
        name: 'Fresh Salmon',
        description: 'Premium quality Atlantic salmon',
        price: 299.99,
        originalPrice: 399.99,
        categoryId: 'cat1',
        categoryName: 'Sea Fish',
        images: const ['image1.jpg', 'image2.jpg'],
        rating: 4.5,
        reviewCount: 120,
        isAvailable: true,
        unit: 'kg',
        weight: 1.0,
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );
    });

    test('should create Product with all required fields', () {
      expect(testProduct.id, '1');
      expect(testProduct.name, 'Fresh Salmon');
      expect(testProduct.price, 299.99);
      expect(testProduct.isAvailable, true);
    });

    test('should calculate discount correctly when originalPrice is provided',
        () {
      expect(testProduct.hasDiscount, true);
      expect(testProduct.discountPercentage, closeTo(25.0, 0.1));
    });

    test('should return false for hasDiscount when no originalPrice', () {
      final productWithoutDiscount = Product(
        id: '2',
        name: 'King Fish',
        description: 'Fresh king fish',
        price: 249.99,
        originalPrice: null, // No original price
        categoryId: 'cat1',
        categoryName: 'Sea Fish',
        images: const ['image.jpg'],
        rating: 4.5,
        reviewCount: 50,
        isAvailable: true,
        unit: 'kg',
        weight: 1.0,
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );
      expect(productWithoutDiscount.hasDiscount, false);
      expect(productWithoutDiscount.discountPercentage, 0);
    });

    test('should return primary image correctly', () {
      expect(testProduct.primaryImage, 'image1.jpg');

      final productWithoutImages = testProduct.copyWith(images: []);
      expect(productWithoutImages.primaryImage, '');
    });

    test('should support copyWith functionality', () {
      final updatedProduct = testProduct.copyWith(
        name: 'Updated Salmon',
        price: 349.99,
        isAvailable: false,
      );

      expect(updatedProduct.name, 'Updated Salmon');
      expect(updatedProduct.price, 349.99);
      expect(updatedProduct.isAvailable, false);
      // Other fields should remain the same
      expect(updatedProduct.id, testProduct.id);
      expect(updatedProduct.categoryId, testProduct.categoryId);
    });

    test('should support equality comparison', () {
      final sameProduct = Product(
        id: '1',
        name: 'Fresh Salmon',
        description: 'Premium quality Atlantic salmon',
        price: 299.99,
        originalPrice: 399.99,
        categoryId: 'cat1',
        categoryName: 'Sea Fish',
        images: const ['image1.jpg', 'image2.jpg'],
        rating: 4.5,
        reviewCount: 120,
        isAvailable: true,
        unit: 'kg',
        weight: 1.0,
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );

      final differentProduct = testProduct.copyWith(id: '2');

      expect(testProduct, equals(sameProduct));
      expect(testProduct, isNot(equals(differentProduct)));
    });
  });
}
