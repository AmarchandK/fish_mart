import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../models/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeDataModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<HomeDataModel> getHomeData() async {
    try {
      // For demo purposes, we'll create mock data
      // In a real app, you would make API calls to get this data

      // Simulate API delay
      await Future<void>.delayed(const Duration(seconds: 1));

      // Create mock home data
      final homeData = HomeDataModel.createMockData();

      return homeData;
    } catch (e) {
      if (e is ServerException || e is NetworkException) rethrow;
      throw ServerException(
          message: 'Failed to load home data: ${e.toString()}');
    }
  }
}
