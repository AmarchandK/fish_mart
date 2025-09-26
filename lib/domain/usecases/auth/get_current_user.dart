import '../../../core/usecase/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class GetCurrentUser implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<User?> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
