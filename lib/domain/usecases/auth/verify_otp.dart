import 'package:equatable/equatable.dart';

import '../../../core/usecase/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';

class VerifyOtp implements UseCase<User, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<User> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.phoneNumber, params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  final String phoneNumber;
  final String otp;

  const VerifyOtpParams({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [phoneNumber, otp];
}
