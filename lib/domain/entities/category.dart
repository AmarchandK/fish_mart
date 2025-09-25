import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final IconData icon;
  final Color color;
  final int productCount;
  final bool isActive;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.color,
    required this.productCount,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        icon,
        color,
        productCount,
        isActive,
        sortOrder,
        createdAt,
        updatedAt,
      ];

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    IconData? icon,
    Color? color,
    int? productCount,
    bool? isActive,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      productCount: productCount ?? this.productCount,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
