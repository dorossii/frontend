import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:authbase_mobile/constants/app_config.dart';
import '../models/user_info.dart';

class AuthManager {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token'; // This is the refresh token
  static String? _cachedAccessToken;
  static DateTime? _tokenExpiry;

  /// リフレッシュトークンを保存
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// リフレッシュトークンを取得
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// ログアウト（トークン削除）
  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    _cachedAccessToken = null;
    _tokenExpiry = null;
  }

  /// アクセストークンを取得（キャッシュ有効なら再利用）
  static Future<String?> getAccessToken() async {
    if (_cachedAccessToken != null &&
        _tokenExpiry != null &&
        DateTime.now().isBefore(_tokenExpiry!.subtract(const Duration(minutes: 1)))) {
      return _cachedAccessToken;
    }

    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      debugPrint("❌ getAccessToken: No refresh token found");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.tokenEndpoint}'),
        headers: {'Authorization': refreshToken},
      );

      debugPrint("🔍 Token response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cachedAccessToken = data['token'];
        _tokenExpiry = DateTime.now().add(const Duration(minutes: 5));
        return _cachedAccessToken;
      } else {
        debugPrint("❌ Token request failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Token request error: $e");
    }
    return null;
  }

  /// トークンを付与してHTTPリクエストを実行
  static Future<http.Response> authenticatedRequest(
    String path, {
    String method = 'GET',
    Map<String, String>? headers,
    Object? body,
  }) async {
    final token = await getAccessToken();
    if (token == null) {
      throw Exception('Failed to get access token');
    }

    final url = Uri.parse('${AppConfig.baseUrl}$path');
    final Map<String, String> requestHeaders = {
      'Authorization': token,
      'Content-Type': 'application/json',
      ...?headers,
    };

    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(url, headers: requestHeaders, body: json.encode(body));
      case 'PUT':
        return await http.put(url, headers: requestHeaders, body: json.encode(body));
      case 'DELETE':
        return await http.delete(url, headers: requestHeaders);
      case 'GET':
      default:
        return await http.get(url, headers: requestHeaders);
    }
  }

  /// 現在のユーザー情報を取得
  static Future<UserInfo?> getCurrentUserInfo() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      debugPrint("❌ getCurrentUserInfo: No refresh token");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.meEndpoint}'),
        headers: {'Authorization': refreshToken},
      );
      
      debugPrint("🔍 ${AppConfig.meEndpoint} response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
      return UserInfo.fromJson(jsonData);
      }
    } catch (e) {
      debugPrint("❌ getCurrentUserInfo error: $e");
    }
    return null;
  }
}
