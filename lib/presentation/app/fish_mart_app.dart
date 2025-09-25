import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/app_theme.dart';
import '../../core/di/injection_container.dart' as di;
import '../blocs/auth/auth_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/category/category_bloc.dart';
import '../pages/splash/splash_page.dart';

class FishMartApp extends StatelessWidget {
  const FishMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => di.sl<ProductBloc>(),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => di.sl<CategoryBloc>(),
        ),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashPage(),
      ),
    );
  }
}
