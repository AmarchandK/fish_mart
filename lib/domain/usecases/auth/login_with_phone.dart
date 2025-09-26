import 'package:equatable/equatable.dart';

import '../../../core/usecase/usecase.dart';
import '../../repositories/auth_repository.dart';

class LoginWithPhone implements UseCase<String, LoginWithPhoneParams> {
  final AuthRepository repository;

  LoginWithPhone(this.repository);

  @override
  Future<String> call(LoginWithPhoneParams params) async {
    return await repository.loginWithPhone(params.phoneNumber);
  }
}

class LoginWithPhoneParams extends Equatable {
  final String phoneNumber;

  const LoginWithPhoneParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
