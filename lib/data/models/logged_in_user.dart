import 'package:do_jobs_application/core/services/cache_services.dart';
import 'package:do_jobs_application/core/consts/string_manager.dart';

class LoggedInUser {
  static Future<void> login(Map<String, dynamic> data) async {
    final cacheService = CacheService();

    // Handle both response structures:
    // 1. Sign-up/Sign-in: { "success": true, "user": {...}, "session": {...} }
    // 2. Legacy: { "result": { "user": {...}, "access_token": "...", ... } }

    Map<String, dynamic>? sessionData;
    Map<String, dynamic>? userData;

    // Check if this is the new format (with 'session' at root level)
    if (data['session'] != null) {
      sessionData = data['session'] as Map<String, dynamic>;
      userData = data['user'] as Map<String, dynamic>?;
    }
    // Check if this is the legacy format (with 'result')
    else if (data['result'] != null) {
      final result = data['result'] as Map<String, dynamic>;
      sessionData = result;
      userData = result['user'] as Map<String, dynamic>?;
    }

    // Store tokens if available
    if (sessionData != null) {
      // Store access token
      final accessToken = sessionData['access_token'] ?? sessionData['token'] ?? '';
      if (accessToken.isNotEmpty) {
        await cacheService.writeCache(
          key: AppStrings.cToken,
          value: accessToken,
        );
      }

      // Store refresh token
      final refreshToken = sessionData['refresh_token'] ?? '';
      if (refreshToken.isNotEmpty) {
        await cacheService.writeCache(
          key: AppStrings.cRefresh,
          value: refreshToken,
        );
      }
    }

    // Store user data if available
    if (userData != null) {
      // Store user ID
      if (userData['id'] != null) {
        await cacheService.writeCache(
          key: 'user_id',
          value: userData['id'].toString(),
        );
      }

      // Store user email
      if (userData['email'] != null) {
        await cacheService.writeCache(
          key: AppStrings.cEmailKey,
          value: userData['email'].toString(),
        );
      }

      // Store user full name
      if (userData['full_name'] != null) {
        await cacheService.writeCache(
          key: AppStrings.cFirstName,
          value: userData['full_name'].toString(),
        );
      }

      // Store user role/account type
      if (userData['account_type'] != null) {
        await cacheService.writeCache(
          key: AppStrings.cUserRole,
          value: userData['account_type'].toString(),
        );
      }
    }
  }

  static Future<void> logout() async {
    final cacheService = CacheService();
    await cacheService.deleteCache(key: AppStrings.cToken);
    await cacheService.deleteCache(key: AppStrings.cRefresh);
    await cacheService.deleteCache(key: 'user_id');
    await cacheService.deleteCache(key: AppStrings.cEmailKey);
    await cacheService.deleteCache(key: AppStrings.cFirstName);
    await cacheService.deleteCache(key: AppStrings.cUserRole);
  }
}
