import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:authbase_mobile/models/task_info.dart';
import '../../constants/app_config.dart';

// タスクの情報を取得する
class TaskService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.taskListEndpoint;
  
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

      // print("レスポンス: $jsonData");
      final List<dynamic> tasks = jsonData;

      /// Modelへ変換
      return tasks.map((e) => TaskInfo.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('タスク情報取得失敗');
  }

  /// タスク情報更新
  Future<Map<String, dynamic>> updateTaskStatus({
    required List<String> taskId,
    required String message,
  }) async {
    /// PUT
    final response = await http.put(
      
      (taskId.length == 1)
      ? Uri.parse('$url/${taskId.first}')  // 単体で更新
      : Uri.parse('{$MockApiResponse.baseUrl}/app/user/tasks/complete'),  // まとめて更新

      headers: {'accept': 'application/json', 'Authorization': token},
      // Todo: 複数の場合は配列c(taskId)
      body: {
        "status": "complete",
        "message": message,
      }
    );
  
    /// 成功
    if (response.statusCode == 200) {
      // Todo: 何も返ってこないからテストデータでしのいでる
      // final data = jsonDecode(response.body);
      final Map<String, dynamic> data = {
        "isChanged": true,
        "requireImage": false,
      };
      
      debugPrint('更新成功');
      debugPrint('✏️ data: $data');

      return data;
    }

    /// 失敗
    debugPrint('更新失敗: ${response.statusCode}');
    debugPrint(response.body);

    throw Exception('タスク更新失敗');

  }

  /// フレンド一覧を取得
  Future<List<TaskInfo>> getFriendPending() async {
    /// GET通信
    final response = await http.get(
      Uri.parse('${MockApiResponse.baseUrl}/app/user/tasks/pending'),

      headers: {'accept': 'application/json', 'Authorization': token},
    );
    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final jsonData = jsonDecode(response.body);

      // print("🫂レスポンス: $jsonData");
      final List<dynamic> tasks = jsonData;

      /// Modelへ変換
      return tasks.map((e) => TaskInfo.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('タスク情報取得失敗');
  }

  /// メッセージ送信処理
  Future<void> sendMessage({
    required String taskId,
    required String friendId,
    required String message,
  }) async {

    // 送信するデータ（マップ型）
    final Map<String, dynamic> requestData = {
      'friendId': friendId,
      'message': message,
    };

    final response = await http.post(
      Uri.parse('$url/$taskId/message'),
      headers: {'accept': 'application/json', 'Authorization': token},
      body: jsonEncode(requestData),
    );
  
    /// 成功
    if (response.statusCode == 200) {
      debugPrint('メッセージ送信成功');
      debugPrint(requestData as String?);
      return;
    }

    /// 失敗
    debugPrint('メッセージ送信失敗: ${response.statusCode}');
    debugPrint(response.body);

    throw Exception('メッセージ送信失敗');
  }

  static void message() {}
}