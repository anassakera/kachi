class Constants {
  // App Information
  static const String appName = 'Check Analysis';
  static const String appVersion = '1.0.0';

  // API Endpoints (to be configured)
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Pagination
  static const int itemsPerPage = 20;

  // Animation Durations
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;

  // Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;

  // File Size Limits (in bytes)
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  // Supported Languages
  static const List<String> supportedLanguages = ['en', 'fr', 'ar'];
}
