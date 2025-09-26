import '../../../core/usecase/usecase.dart';
import '../../entities/home_data.dart';
import '../../repositories/home_repository.dart';

class GetHomeData implements UseCase<HomeData, NoParams> {
  final HomeRepository repository;

  GetHomeData(this.repository);

  @override
  Future<HomeData> call(NoParams params) async {
    return await repository.getHomeData();
  }
}
