import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> loginWithPhone(String phoneNumber);
  Future<UserModel> verifyOtp(String phoneNumber, String otp);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> loginWithPhone(String phoneNumber) async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.post(
        '/auth/login',
        data: {'phoneNumber': phoneNumber},
      );

      // For demo purposes with JSONPlaceholder, we'll simulate the response
      if (response.containsKey('success') && response['success'] == true) {
        return response['data']['sessionId'] as String;
      } else {
        // Simulate successful response for demo
        return 'demo_session_${DateTime.now().millisecondsSinceEpoch}';
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Login failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> verifyOtp(String phoneNumber, String otp) async {
    try {
      // Sample API call - replace with real endpoint
      final response = await client.post(
        '/auth/verify-otp',
        data: {
          'phoneNumber': phoneNumber,
          'otp': otp,
        },
      );

      // For demo purposes, simulate successful OTP verification
      if (response.containsKey('success') && response['success'] == true) {
        return UserModel.fromJson(response['data']['user'] as Map<String, dynamic>);
      } else {
        // Simulate successful user for demo
        return UserModel(
          id: 'demo_user_123',
          phoneNumber: phoneNumber,
          name: 'Demo User',
          email: null,
          profileImage: null,
          createdAt: null,
          updatedAt: null,
        );
      }
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'OTP verification failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Sample API call - replace with real endpoint
      await client.post('/auth/logout');
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(message: 'Logout failed: ${e.toString()}');
    }
  }
}
