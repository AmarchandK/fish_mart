import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> loginWithPhone(String phoneNumber);
  Future<Either<Failure, User>> verifyOtp(String phoneNumber, String otp);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, bool>> isLoggedIn();
}
