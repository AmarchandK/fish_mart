class AppConfig {
  static const String appName = 'Fish Mart';
  static const String appVersion = '1.0.0';

  // API Configuration - Using JSONPlaceholder as sample API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String apiVersion = 'v1';

  // Firebase Configuration
  static const String firebaseProjectId = 'fish-mart-app';

  // App Constants
  static const int splashDuration = 3000; // milliseconds
  static const int otpLength = 6;
  static const int sessionTimeout = 30; // minutes

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Cache Configuration
  static const int imageCacheDuration = 7; // days
  static const int dataCacheDuration = 24; // hours

  // App Store Links
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.fishmart.app';
  static const String appStoreUrl =
      'https://apps.apple.com/app/fish-mart/id123456789';

  // Support
  static const String supportEmail = 'support@fishmart.com';
  static const String supportPhone = '+1-800-FISH-MART';

  // Social Media
  static const String facebookUrl = 'https://facebook.com/fishmart';
  static const String instagramUrl = 'https://instagram.com/fishmart';
  static const String twitterUrl = 'https://twitter.com/fishmart';
}
