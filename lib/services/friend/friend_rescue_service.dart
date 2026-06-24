import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../models/friend_rescue.dart';
import '../../constants/app_config.dart';

// フレンドの情報を取得する
class FriendRescueService {
  /// API URL
  static const String getUrl =
      MockApiResponse.baseUrl + MockApiResponse.rescueFriendListEndpoint;

  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// フレンド情報取得
  Future<List<RescueFriend>> fetchFriendInfo() async {
    /// GET通信
    final response = await http.get(
      Uri.parse(getUrl),

      headers: {'accept': 'application/json', 'Authorization': token},
    );

    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final List<dynamic> friends = jsonDecode(response.body);

      return friends.map((e) => RescueFriend.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('フレンド情報取得失敗');
  }
}
// フレンドのレスキューするかを登録する
Future<bool> registerRescueFriends(List<String> uuids) async {
  /// API URL
  const String postUrl =
      MockApiResponse.baseUrl + MockApiResponse.registerRescueFriendEndpoint;

  /// 認証トークン
  const String token = 'mock-token-super-secret';

  /// POST通信
  final response = await http.post(
    Uri.parse(postUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': token,
    },
    body: jsonEncode({'uuids': uuids}),
  );

  /// 通信成功
  if (response.statusCode == 200) {
    return true;
  }

  /// 通信失敗
  debugPrint('Failed to post UUID list: ${response.statusCode}');
  return false;
}