import '../../../core/usecase/usecase.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetFeaturedProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetFeaturedProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) async {
    return await repository.getFeaturedProducts();
  }
}
