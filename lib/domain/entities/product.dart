import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String categoryId;
  final String categoryName;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final bool isAvailable;
  final String unit; // kg, piece, etc.
  final double? weight;
  final Map<String, dynamic>? nutritionalInfo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.isAvailable,
    required this.unit,
    this.weight,
    this.nutritionalInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  String get primaryImage => images.isNotEmpty ? images.first : '';

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    originalPrice,
    categoryId,
    categoryName,
    images,
    rating,
    reviewCount,
    isAvailable,
    unit,
    weight,
    nutritionalInfo,
    createdAt,
    updatedAt,
  ];

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? categoryId,
    String? categoryName,
    List<String>? images,
    double? rating,
    int? reviewCount,
    bool? isAvailable,
    String? unit,
    double? weight,
    Map<String, dynamic>? nutritionalInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isAvailable: isAvailable ?? this.isAvailable,
      unit: unit ?? this.unit,
      weight: weight ?? this.weight,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
