import 'dart:convert';

import 'package:flutter/material.dart';

import '../../constants/app_config.dart';
import '../../models/user_lifestyle_info.dart';
import '../../models/user_register_info.dart';
import '../auth_manager.dart';

/// 初回ユーザー登録・生活環境情報登録を行うサービス
///
/// アクセストークンが必須のため、`AuthManager.authenticatedRequest` を使用して
/// Authorizationヘッダーにアクセストークンを付与して通信する
class UserRegisterService {
  /// 初回ユーザー登録
  Future<UserRegisterResponse> registerUser(UserRegisterRequest request) async {
    debugPrint('初回ユーザー登録リクエスト: ${AppConfig.userRegisterEndpoint} - ${jsonEncode(request.toJson())}');

    final response = await AuthManager.authenticatedRequest(
      AppConfig.userRegisterEndpoint,
      method: 'POST',
      body: request.toJson(),
    );

    debugPrint('初回ユーザー登録レスポンス: ${response.statusCode} - ${response.body}');

    /// 通信成功
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return UserRegisterResponse.fromJson(jsonData);
    }

    /// 通信失敗
    debugPrint('初回ユーザー登録失敗: ${response.statusCode} - ${response.body}');
    throw Exception('初回ユーザー登録失敗');
  }

  /// 生活環境情報の登録（初回）
  Future<UserLifestyleInfo> registerLifestyle(UserLifestyleInfo lifestyle) async {
    debugPrint('生活環境情報登録リクエスト: ${AppConfig.userLifestyleEndpoint} - ${jsonEncode(lifestyle.toJson())}');

    final response = await AuthManager.authenticatedRequest(
      AppConfig.userLifestyleEndpoint,
      method: 'POST',
      body: lifestyle.toJson(),
    );

    debugPrint('生活環境情報登録レスポンス: ${response.statusCode} - ${response.body}');

    /// 通信成功
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return UserLifestyleInfo.fromJson(jsonData);
    }

    /// 通信失敗
    debugPrint('生活環境情報登録失敗: ${response.statusCode} - ${response.body}');
    throw Exception('生活環境情報登録失敗');
  }
}
