import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../models/friend_rescue.dart';
import '../../constants/app_config.dart';
import '../auth_manager.dart';

// フレンドの情報を取得する
class FriendRescueService {
  /// フレンド情報取得
  Future<List<RescueFriend>> fetchFriendInfo() async {
    final response = await AuthManager.authenticatedRequest(
      AppConfig.friendListEndpoint,
      method: 'GET',
    );

    /// 通信成功
    if (response.statusCode == 200) {
      debugPrint('レスキュー情報取得成功: ${response.body}');
      
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> friendsList = jsonData['friends'] ?? [];

      /// Modelへ変換
      return friendsList
          .map((e) => RescueFriend.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('フレンド情報取得失敗');
  }
}

// フレンドのレスキューするかを登録する
Future<bool> registerRescueFriends(List<String> uuids) async {
  /// POST通信
  final response = await AuthManager.authenticatedRequest(
    AppConfig.registerRescueFriendEndpoint,
    method: 'POST',
    body: uuids,
  );

  /// 通信成功
  if (response.statusCode == 200) {
    return true;
  }

  /// 通信失敗
  debugPrint('Failed to post UUID list: ${response.statusCode}');
  return false;
}