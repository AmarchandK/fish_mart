import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetFeaturedProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetFeaturedProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getFeaturedProducts();
  }
}
