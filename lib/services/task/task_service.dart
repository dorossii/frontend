import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:authbase_mobile/models/task_info.dart';
import '../../constants/app_config.dart';

// タスクの情報を取得する
class TaskService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.friendListEndpoint;
  
  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// タスク情報取得
  Future<List<TaskInfo>> fetchTaskInfo() async {
    /// GET通信
    final response = await http.get(
      Uri.parse(url),

      headers: {'accept': 'application/json', 'Authorization': token},
    );

    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final jsonData = jsonDecode(response.body);

      final List tasks = jsonData['tasks'];

      /// Modelへ変換
      return tasks.map((e) => TaskInfo.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('タスク情報取得失敗');
  }

}