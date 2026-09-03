import 'dart:convert';
import 'package:authbase_mobile/services/auth_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:authbase_mobile/models/task_info.dart';
import '../../constants/app_config.dart';

/// タスクの情報を取得する
class TaskService {
  /// API URL
  static const String url =
      MockApiResponse.baseUrl + MockApiResponse.taskListEndpoint;

  /// 認証トークン
  static const String token = 'mock-token-super-secret';

  /// ==== タスク情報取得 ====
  Future<List<TaskInfo>> fetchTaskInfo() async {
    /// GET通信
    final response = await AuthManager.authenticatedRequest(
      AppConfig.taskListEndpoint,
      method: 'GET',
    );

    /// 通信成功
    if (response.statusCode == 200) {
      debugPrint("タスク一覧取得完了");

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

  // ==== タスク情報更新 ====
  Future<Map<String, dynamic>> updateTaskStatus({
    required List<String> selectedTaskId,
    required String message,
  }) async {
    final response;

    if (selectedTaskId.length == 1) {
      // 単体で更新
      response = await AuthManager.authenticatedRequest(
        '${AppConfig.taskListEndpoint}/${selectedTaskId.first}',
        method: 'PUT',
        body: {"status": "complete", "message": message},
      );
    } else {
      // まとめて更新
      final requestBody = selectedTaskId.map((taskId) {
        return {"id": taskId, "status": "complete"};
      }).toList();

      response = await AuthManager.authenticatedRequest(
        '/app/user/tasks/complete',
        method: 'POST',
        body: requestBody,
      );
    }

    debugPrint('ステータスコード: ${response.statusCode}');
    debugPrint('レスポンス: ${response.body}');

    /// 成功
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('タスク更新失敗');
  }

  // ==== 承認待ちタスク一覧取得 ====
  Future<List<TaskInfo>> getFriendPending() async {
    /// GET通信
    final response = await AuthManager.authenticatedRequest(
      '/app/user/tasks/pending',
      method: 'GET',
    );

    /// 通信成功
    if (response.statusCode == 200) {
      /// JSON変換
      final jsonData = jsonDecode(response.body);

      final List<dynamic> tasks = jsonData;

      /// Modelへ変換
      return tasks.map((e) => TaskInfo.fromJson(e)).toList();
    }

    /// 通信失敗
    debugPrint('Failed to load friend info: ${response.statusCode}');
    throw Exception('タスク情報取得失敗');
  }

  /// ==== メッセージ送信処理 ====
  Future<void> sendMessage({
    // required String selectedTaskId,
    required String sendUserId,
    required String message,
  }) async {
    final endpoint = '${AppConfig.taskListEndpoint}/message';

    final response = await AuthManager.authenticatedRequest(
      endpoint,
      method: 'POST',
      body: {'friendId': sendUserId, 'message': message},
    );

    // debugPrint('ステータス：${response.statusCode}');
    // debugPrint('レスポンス：${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('メッセージ送信に失敗しました: ${response.statusCode}');
    }
  }

  /// 写真アップロード処理
  Future<void> sendPicture({
    required String selectedTaskId,
    required String imagePath,
  }) async {
    final endpoint = '${AppConfig.taskListEndpoint}/$selectedTaskId/image';

    final token = await AuthManager.getAccessToken();

    if (token == null) {
      throw Exception('Failed to get access token');
    }

    final url = Uri.parse('${AppConfig.baseUrl}$endpoint');

    final request = http.MultipartRequest('POST', url);

    // authenticatedRequest() と同じ認証方式
    request.headers['Authorization'] = token;

    // Go側の FormFile("image") に対応
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    // debugPrint('画像アップロード開始');
    // debugPrint('endpoint: $endpoint');
    // debugPrint('imagePath: $imagePath');

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);

    // debugPrint('ステータス：${response.statusCode}');
    // debugPrint('レスポンス：${response.body}');

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('画像アップロードに失敗しました: ${response.statusCode}');
    }
  }
}
