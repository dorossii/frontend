import 'dart:async';
import 'package:flutter/material.dart';

import '../../models/user_status.dart';
import '../../models/activity_log.dart'; // ログモデルをインポート
import '../../services/user/user_service.dart';
import '../models/status.dart';

class UserViewModel extends ChangeNotifier {
  /// APIから取得したユーザー情報
  UserStatus? userStatus;

  /// APIから取得したお知らせ・ログ一覧
  List<ActivityLog> logs = [];

  /// ローディング状態
  bool isLoading = false;

  /// API通信クラス
  final UserService _service = UserService();

  /// 定期実行用タイマー
  Timer? _pollingTimer;

  /// 初期化（タイマー開始）
  Future<void> initialize({
    Duration interval = const Duration(seconds: 5),
  }) async {
    // 初回取得
    await fetchUser();
    // 定期取得を開始
    startPolling(interval: interval);
  }

  /// ポーリング（定期実行）を開始
  void startPolling({Duration interval = const Duration(seconds: 5)}) {
    _pollingTimer?.cancel(); // 二重起動防止
    _pollingTimer = Timer.periodic(interval, (_) {
      fetchUserStatusQuietly();
    });
  }

  /// ポーリングを停止
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// バックグラウンドでの定期更新用（画面全体のローディングを出さずに更新）
  Future<void> fetchUserStatusQuietly() async {
    try {
      // ステータスとログを並行して取得（または順番に取得）
      final results = await Future.wait([
        _service.fetchUserStatus(),
        _service.fetchLogs(), // ※ UserServiceに fetchLogs() を実装した場合
      ]);

      userStatus = results[0] as UserStatus?;
      logs = (results[1] as List<ActivityLog>?) ?? [];

      notifyListeners(); // 画面を再描画
    } catch (e) {
      debugPrint('定期ステータス・ログ取得エラー: $e');
    }
  }

  /// 初回や明示的なユーザー操作での情報取得（ローディングを伴う）
  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();

    try {
      /// API通信（ステータスとログを同時に取得）
      final results = await Future.wait([
        _service.fetchUserStatus(),
        _service.fetchLogs(),
      ]);

      userStatus = results[0] as UserStatus?;
      logs = (results[1] as List<ActivityLog>?) ?? [];
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// 汚さレベルから状態取得
  LifeState get currentState {
    return LifeState.fromValue(userStatus?.dirtLevel ?? 0);
  }

  /// HP表示用
  int get hp {
    return ((userStatus?.healthPoint ?? 0) / 10).floor();
  }

  /// ユーザー名
  String get userName {
    return userStatus?.userName ?? "";
  }

  /// 生年月日
  String get birthDate {
    final timestamp = userStatus?.birthDate;

    if (timestamp == null || timestamp == 0) {
      return "";
    }

    final date = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    ).toLocal();

    return '${date.year}/${date.month}/${date.day}';
  }
  String get bgColors {
  return userStatus?.bgColors ?? "";
}
String get userIcon {
  return userStatus?.userIcon ?? "";
}
/// 居住タイプ
String get livingType {
  switch (userStatus?.livingType) {
    case 'alone':
      return '一人暮らし';
    case 'family':
      return '実家暮らし';
    case 'share':
      return 'シェアハウス';
    default:
      return '';
  }
}

  /// 汚さレベル
  int get dirtLevel {
    return userStatus?.dirtLevel ?? 0;
  }

  /// ViewModelが破棄された時にタイマーも停止
  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
