import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/friend_info.dart';
import '../../constants/app_config.dart';

// フレンドの情報を取得する
class FriendService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.friendListEndpoint;

  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// フレンド情報取得
  Future<FriendInfo> fetchFriendInfo() async {
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
      return FriendInfo.fromJson(jsonData);
    }

    /// 通信失敗
    throw Exception('フレンド情報取得失敗');
  }
}
