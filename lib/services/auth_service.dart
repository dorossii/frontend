import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_info.dart';
import 'package:authbase_mobile/constants/app_config.dart';



class AuthService {
  static final String _meEndpoint = '${AppConfig.baseUrl}/auth/me';
  static final String _exchangeEndpoint = '${AppConfig.baseUrl}/auth/bridge/exchange';

  /// トークンを使用してユーザー情報を取得する
  /// 有効なトークンでない場合は null を返す
  Future<UserInfo?> getUserInfo(String token) async {
    try {
      final response = await http.get(
        Uri.parse(_meEndpoint),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return UserInfo.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// ブリッジトークンをリフレッシュトークンに交換する
  Future<String?> exchangeBridgeToken(String bridgeToken) async {
    try {
      final response = await http.get(
        Uri.parse(_exchangeEndpoint),
        headers: {
          'Authorization': 'Bearer $bridgeToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['refresh_token'];
      } else {
        debugPrint('❌ Token exchange failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('❌ Token exchange error: $e');
      return null;
    }
  }


  /// トークンが有効かどうかを返す
  Future<bool> isValidToken(String token) async {
    final userInfo = await getUserInfo(token);
    return userInfo != null;
  }
}
