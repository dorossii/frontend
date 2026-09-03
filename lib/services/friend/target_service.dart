import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/target_info.dart';
import '../../constants/app_config.dart';
import '../auth_manager.dart';

// ターゲットの情報を取得する
class TargetService {
  Future<TargetInfo> fetchTargetInfo() async {
    /// GET通信
    final response = await AuthManager.authenticatedRequest(
      AppConfig.targetListEndpoint,
      method: 'GET',
    );

    /// 通信成功
    if (response.statusCode == 200) {
      debugPrint('ターゲット情報取得成功');
      debugPrint('target response: ${response.body}');

      /// JSON変換
      final Map<String, dynamic> jsonData =
          jsonDecode(response.body);

      /// Modelへ変換
      return TargetInfo.fromJson(jsonData);
    }

    /// 通信失敗
    debugPrint(
      'Failed to load target info: ${response.statusCode}',
    );

    throw Exception('ターゲット情報取得失敗');
  }
  // ターゲットの情報を更新する
  Future<void> updateTargetInfo(TargetInfo targetInfo) async {
  /// PUT通信
  final response = await AuthManager.authenticatedRequest(
    AppConfig.targetListEndpoint,
    method: 'PUT',
    body: targetInfo.toJson(),
  );

  /// 通信成功
  if (response.statusCode == 200) {
    debugPrint('ターゲット情報更新成功');
    return;
  }

  /// 通信失敗
  debugPrint(
    'Failed to update target info: ${response.statusCode}',
  );
  debugPrint(
    'target update response: ${response.body}',
  );

  throw Exception('ターゲット情報更新失敗');
}
}