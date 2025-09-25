import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/otp_verification_page.dart';
import '../../presentation/pages/main/main_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/categories/categories_page.dart';
import '../../presentation/pages/profile/profile_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String main = '/main';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash Screen
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Authentication Routes
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: otpVerification,
        name: 'otp-verification',
        builder: (context, state) {
          final phoneNumber = state.uri.queryParameters['phoneNumber'] ?? '';
          return OtpVerificationPage(phoneNumber: phoneNumber);
        },
      ),

      // Main App Routes
      GoRoute(
        path: main,
        name: 'main',
        builder: (context, state) => const MainPage(),
        routes: [
          GoRoute(
            path: 'home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'categories',
            name: 'categories',
            builder: (context, state) => const CategoriesPage(),
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
