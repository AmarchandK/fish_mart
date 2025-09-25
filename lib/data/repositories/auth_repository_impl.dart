import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SharedPreferences? sharedPreferences;
  final Logger _logger = Logger();

  AuthRepositoryImpl({
    required this.remoteDataSource,
    this.sharedPreferences,
  });

  @override
  Future<Either<Failure, String>> loginWithPhone(String phoneNumber) async {
    try {
      final sessionId = await remoteDataSource.loginWithPhone(phoneNumber);
      return Right(sessionId);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(
      String phoneNumber, String otp) async {
    try {
      final user = await remoteDataSource.verifyOtp(phoneNumber, otp);

      // Save user data locally
      await _saveUserLocally(user);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await _clearUserData();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userData = sharedPreferences?.getString('user_data');
      if (userData != null) {
        // In a real app, you'd parse the JSON and create a User object
        // For now, return null as we don't have the user data structure
        return const Right(null);
      }
      return const Right(null);
    } catch (e) {
      return Left(
          CacheFailure(message: 'Failed to get user data: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final userData = sharedPreferences?.getString('user_data');
      return Right(userData != null);
    } catch (e) {
      return Left(CacheFailure(
          message: 'Failed to check login status: ${e.toString()}'));
    }
  }

  Future<void> _saveUserLocally(User user) async {
    try {
      // In a real app, you'd serialize the user object to JSON
      await sharedPreferences?.setString('user_data', user.id);
      await sharedPreferences?.setBool('is_logged_in', true);
    } catch (e) {
      // Log error but don't throw - local storage failure shouldn't fail the login
      _logger.w('Failed to save user locally: $e');
    }
  }

  Future<void> _clearUserData() async {
    try {
      await sharedPreferences?.remove('user_data');
      await sharedPreferences?.setBool('is_logged_in', false);
    } catch (e) {
      // Log error but don't throw
      _logger.w('Failed to clear user data: $e');
    }
  }
}
