import 'package:flutter/material.dart';

import '../../domain/entities/home_data.dart';
import 'category_model.dart';
import 'product_model.dart';

class HomeDataModel extends HomeData {
  const HomeDataModel({
    required super.categories,
    required super.featuredProducts,
    required super.bannerImages,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      categories: (json['categories'] as List<dynamic>)
          .map((category) =>
              CategoryModel.fromJson(category as Map<String, dynamic>))
          .toList(),
      featuredProducts: (json['featuredProducts'] as List<dynamic>)
          .map((product) =>
              ProductModel.fromJson(product as Map<String, dynamic>))
          .toList(),
      bannerImages: (json['bannerImages'] as List<dynamic>)
          .map((banner) => banner as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories
          .map((category) => (category as CategoryModel).toJson())
          .toList(),
      'featuredProducts': featuredProducts
          .map((product) => (product as ProductModel).toJson())
          .toList(),
      'bannerImages': bannerImages,
    };
  }

  // Mock data for demo purposes
  factory HomeDataModel.createMockData() {
    final now = DateTime.now();
    return HomeDataModel(
      categories: [
        CategoryModel(
          id: '1',
          name: 'Sea Fish',
          description: 'Fresh sea fish caught daily',
          imageUrl:
              'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300',
          icon: Icons.waves,
          color: const Color(0xFF0077BE),
          productCount: 15,
          isActive: true,
          sortOrder: 1,
          createdAt: now,
          updatedAt: now,
        ),
        CategoryModel(
          id: '2',
          name: 'Boat Fish',
          description: 'Premium boat fish selection',
          imageUrl:
              'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300',
          icon: Icons.sailing,
          color: const Color(0xFF00A86B),
          productCount: 12,
          isActive: true,
          sortOrder: 2,
          createdAt: now,
          updatedAt: now,
        ),
        CategoryModel(
          id: '3',
          name: 'Vanchi Fish',
          description: 'Traditional vanchi fish varieties',
          imageUrl:
              'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300',
          icon: Icons.anchor,
          color: const Color(0xFFFF6B35),
          productCount: 8,
          isActive: true,
          sortOrder: 3,
          createdAt: now,
          updatedAt: now,
        ),
        CategoryModel(
          id: '4',
          name: 'Meat Products',
          description: 'Fresh meat and seafood products',
          imageUrl:
              'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300',
          icon: Icons.restaurant,
          color: const Color(0xFFE53E3E),
          productCount: 20,
          isActive: true,
          sortOrder: 4,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      featuredProducts: [
        ProductModel(
          id: '1',
          name: 'Fresh Salmon',
          description: 'Premium quality fresh salmon',
          price: 299.99,
          originalPrice: 399.99,
          categoryId: '1',
          categoryName: 'Sea Fish',
          images: [
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300'
          ],
          rating: 4.5,
          reviewCount: 128,
          isAvailable: true,
          unit: 'kg',
          weight: 1.0,
          createdAt: now,
          updatedAt: now,
        ),
        ProductModel(
          id: '2',
          name: 'King Fish',
          description: 'Fresh king fish, perfect for curry',
          price: 249.99,
          originalPrice: null,
          categoryId: '2',
          categoryName: 'Boat Fish',
          images: [
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300'
          ],
          rating: 4.8,
          reviewCount: 89,
          isAvailable: true,
          unit: 'kg',
          weight: 1.5,
          createdAt: now,
          updatedAt: now,
        ),
        ProductModel(
          id: '3',
          name: 'Fresh Prawns',
          description: 'Large fresh prawns, cleaned and ready',
          price: 399.99,
          originalPrice: 499.99,
          categoryId: '3',
          categoryName: 'Vanchi Fish',
          images: [
            'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300'
          ],
          rating: 4.6,
          reviewCount: 156,
          isAvailable: false,
          unit: 'kg',
          weight: 0.5,
          createdAt: now,
          updatedAt: now,
        ),
        ProductModel(
          id: '4',
          name: 'Tuna Steaks',
          description: 'Premium tuna steaks, sushi grade',
          price: 199.99,
          originalPrice: null,
          categoryId: '4',
          categoryName: 'Meat Products',
          images: [
            'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300'
          ],
          rating: 4.3,
          reviewCount: 67,
          isAvailable: true,
          unit: 'kg',
          weight: 0.75,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      bannerImages: [
        'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800',
        'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
        'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=800',
      ],
    );
  }
}
