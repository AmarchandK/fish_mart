import 'package:equatable/equatable.dart';

import '../../../core/usecase/usecase.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call(GetProductsParams params) async {
    return await repository.getProducts(
      page: params.page,
      limit: params.limit,
      categoryId: params.categoryId,
      searchQuery: params.searchQuery,
    );
  }
}

class GetProductsParams extends Equatable {
  final int page;
  final int limit;
  final String? categoryId;
  final String? searchQuery;

  const GetProductsParams({
    this.page = 1,
    this.limit = 20,
    this.categoryId,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [page, limit, categoryId, searchQuery];
}
