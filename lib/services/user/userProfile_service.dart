import 'package:flutter/material.dart';

import '../../constants/app_config.dart';
import '../../models/user_profile.dart';
import '../auth_manager.dart';

class UserProfileService {
  /// プロフィール情報をPUTで更新
  Future<bool> updateProfile(UserProfile profile) async {
    try {
      final mapData = profile.toUpdateJson();

      final response = await AuthManager.authenticatedRequest(
        AppConfig.userProfileEndpoint,
        method: 'PUT',
        body: mapData, // ← jsonEncodeせず、Mapのまま渡す！
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('UserProfileService Error: $e');
      return false;
    }
  }
}