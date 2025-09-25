import 'package:flutter/material.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryById(String categoryId);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.get('/categories');

      // For demo purposes, simulate category data
      if (response.containsKey('success') && response['success'] == true) {
        final categories = (response['data']['categories'] as List)
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return categories;
      } else {
        // Return demo categories
        return _getDemoCategories();
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to fetch categories: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.get('/categories/$categoryId');

      if (response.containsKey('success') && response['success'] == true) {
        return CategoryModel.fromJson(
            response['data']['category'] as Map<String, dynamic>);
      } else {
        // Return demo category
        return _getDemoCategories().firstWhere(
          (cat) => cat.id == categoryId,
          orElse: () => _getDemoCategories().first,
        );
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to fetch category: ${e.toString()}');
    }
  }

  List<CategoryModel> _getDemoCategories() {
    final now = DateTime.now();
    return [
      CategoryModel(
        id: '1',
        name: 'Sea Fish',
        description: 'Fresh fish from the sea',
        imageUrl:
            'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=300',
        icon: Icons.waves,
        color: const Color(0xFF0077BE),
        productCount: 25,
        isActive: true,
        sortOrder: 1,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '2',
        name: 'Boat Fish',
        description: 'Fresh fish caught by boat',
        imageUrl:
            'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=300',
        icon: Icons.sailing,
        color: const Color(0xFF00A86B),
        productCount: 18,
        isActive: true,
        sortOrder: 2,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '3',
        name: 'Vanchi Fish',
        description: 'Traditional boat fish',
        imageUrl:
            'https://images.unsplash.com/photo-1563379091339-03246963d30a?w=300',
        icon: Icons.anchor,
        color: const Color(0xFFFF6B35),
        productCount: 12,
        isActive: true,
        sortOrder: 3,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '4',
        name: 'Meat Products',
        description: 'Fresh meat and seafood',
        imageUrl:
            'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=300',
        icon: Icons.restaurant,
        color: const Color(0xFFE53E3E),
        productCount: 8,
        isActive: true,
        sortOrder: 4,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}
