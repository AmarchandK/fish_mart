import '../../../core/usecase/usecase.dart';
import '../../repositories/auth_repository.dart';

class IsLoggedIn implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  IsLoggedIn(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.isLoggedIn();
  }
}
