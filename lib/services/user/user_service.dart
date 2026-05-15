import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/user_status.dart';
import '../../constants/app_config.dart';

// ユーザーのステータスを取得する
class UserService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.topStatusEndpoint;

  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// ユーザー情報取得
  Future<UserStatus> fetchUserStatus() async {
    /// GET通信
    final response = await http.get(
      Uri.parse(url),

      headers: {'accept': 'application/json', 'Authorization': token},
    );

    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      /// Modelへ変換
      return UserStatus.fromJson(jsonData);
    }

    /// 通信失敗
    throw Exception('ユーザー情報取得失敗');
  }
}
