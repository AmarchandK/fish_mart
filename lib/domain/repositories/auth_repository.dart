import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> loginWithPhone(String phoneNumber);
  Future<User> verifyOtp(String phoneNumber, String otp);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> isLoggedIn();
}
