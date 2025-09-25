import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.originalPrice,
    required super.categoryId,
    required super.categoryName,
    required super.images,
    required super.rating,
    required super.reviewCount,
    required super.isAvailable,
    required super.unit,
    super.weight,
    super.nutritionalInfo,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      categoryId: json['categoryId']?.toString() ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : <String>[],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      isAvailable: json['isAvailable'] as bool? ?? true,
      unit: json['unit'] as String? ?? 'piece',
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      nutritionalInfo: json['nutritionalInfo'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'isAvailable': isAvailable,
      'unit': unit,
      'weight': weight,
      'nutritionalInfo': nutritionalInfo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  ProductModel copyWith({
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
    return ProductModel(
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
