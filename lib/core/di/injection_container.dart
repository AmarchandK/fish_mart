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
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/auth/login_with_phone.dart';
import '../../domain/usecases/auth/verify_otp.dart';
import '../../domain/usecases/auth/get_current_user.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/is_logged_in.dart';
import '../../domain/usecases/product/get_products.dart';
import '../../domain/usecases/product/get_featured_products.dart';
import '../../domain/usecases/category/get_categories.dart';
import '../../domain/usecases/home/get_home_data.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/category/category_bloc.dart';
import '../../presentation/blocs/home/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginWithPhone: sl(),
        verifyOtp: sl(),
        getCurrentUser: sl(),
        logout: sl(),
        isLoggedIn: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => LoginWithPhone(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => IsLoggedIn(sl()));

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

  //! Features - Home
  // Bloc
  sl.registerFactory(() => HomeBloc(getHomeData: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetHomeData(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
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
