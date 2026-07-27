import 'dart:convert';

import '../../../models/user_status.dart';
import '../../constants/app_config.dart';
import '../auth_manager.dart';

// ユーザーのステータスを取得する
class UserService {
  Future<UserStatus> fetchUserStatus() async {
  // ユーザー情報取得
  final response = await AuthManager.authenticatedRequest(
      AppConfig.topStatusEndpoint,
      method: 'GET',
    );
  
  if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return UserStatus.fromJson(jsonData);
    }

    /// 通信失敗
    throw Exception('ユーザー情報取得失敗');
  }
}
