import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../router/app_router.dart';
import '../network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/category_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/auth/login_with_phone.dart';
import '../../domain/usecases/auth/verify_otp.dart';
import '../../domain/usecases/product/get_products.dart';
import '../../domain/usecases/product/get_featured_products.dart';
import '../../domain/usecases/category/get_categories.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/category/category_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginWithPhone: sl(),
        verifyOtp: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => LoginWithPhone(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      sharedPreferences: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Product
  // Bloc
  sl.registerFactory(() => ProductBloc(
        getProducts: sl(),
        getFeaturedProducts: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetFeaturedProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  //! Features - Category
  // Bloc
  sl.registerFactory(() => CategoryBloc(getCategories: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));
  sl.registerLazySingleton(() => Logger());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<GoRouter>(() => AppRouter.router);
}
