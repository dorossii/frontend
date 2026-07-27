import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/friend_info.dart';
import '../../constants/app_config.dart';
import '../auth_manager.dart';

// フレンドの情報を取得する
class FriendService {
  Future<List<FriendInfo>> fetchFriendInfo() async {
    /// GET通信
    final response = await AuthManager.authenticatedRequest(
      AppConfig.friendListEndpoint,
      method: 'GET',
    );

    /// 通信成功
    if (response.statusCode == 200) {
      debugPrint('フレンド情報取得成功');
      /// JSON変換
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> friends = jsonData['friends'];

      /// Modelへ変換
      return friends
          .map((e) => FriendInfo.fromJson(e as Map<String, dynamic>))
          .toList();
      
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('フレンド情報取得失敗');
  }
}
