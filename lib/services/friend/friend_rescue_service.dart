import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../models/friend_rescue.dart';
import '../../constants/app_config.dart';

// フレンドの情報を取得する
class FriendRescueService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.friendListEndpoint;

  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// フレンド情報取得
  Future<List<RescueFriend>> fetchFriendInfo() async {
    /// GET通信
    final response = await http.get(
      Uri.parse(url),

      headers: {'accept': 'application/json', 'Authorization': token},
    );

    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final jsonData = jsonDecode(response.body);

      final List friends = jsonData['friends'];

      /// Modelへ変換
      return friends.map((e) => RescueFriend.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('フレンド情報取得失敗');
   
  }
}
