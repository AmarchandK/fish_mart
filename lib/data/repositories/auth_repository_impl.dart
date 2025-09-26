import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../../core/error/exceptions.dart';
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
  Future<String> loginWithPhone(String phoneNumber) async {
    try {
      final sessionId = await remoteDataSource.loginWithPhone(phoneNumber);
      return sessionId;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<User> verifyOtp(String phoneNumber, String otp) async {
    try {
      final user = await remoteDataSource.verifyOtp(phoneNumber, otp);

      // Save user data locally
      await _saveUserLocally(user);

      return user;
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
      await _clearUserData();
    } on ServerException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userData = sharedPreferences?.getString('user_data');
      if (userData != null) {
        // In a real app, you'd parse the JSON and create a User object
        // For now, return null as we don't have the user data structure
        return null;
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get user data: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final userData = sharedPreferences?.getString('user_data');
      return userData != null;
    } catch (e) {
      throw CacheException(
          message: 'Failed to check login status: ${e.toString()}');
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
