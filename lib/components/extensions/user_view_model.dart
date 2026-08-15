import 'dart:async';
import 'package:flutter/material.dart';

import '../../models/user_status.dart';
import '../../services/user/user_service.dart';
import '../models/status.dart';

class UserViewModel extends ChangeNotifier {

  /// APIから取得したユーザー情報
  UserStatus? userStatus;

  /// ローディング状態
  bool isLoading = false;

  /// API通信クラス
  final UserService _service = UserService();

  /// 定期実行用タイマー
  Timer? _pollingTimer;

  /// 初期化（タイマー開始）
  Future<void> initialize({Duration interval = const Duration(seconds: 5)}) async {
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
      final newStatus = await _service.fetchUserStatus();
      userStatus = newStatus;
      debugPrint('[Timer] 5秒経過: ステータスを更新しました (${DateTime.now()})');
      notifyListeners(); // 画面を再描画
    } catch (e) {
      debugPrint('定期ステータス取得エラー: $e');
    }
  }

  /// 初回や明示的なユーザー操作での情報取得（ローディングを伴う）
  Future<void> fetchUser() async {
    isLoading = true;
    notifyListeners();

    try {
      /// API通信
      userStatus = await _service.fetchUserStatus();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  /// 汚さレベルから状態取得
  LifeState get currentState {
    return LifeState.fromValue(
      userStatus?.dirtLevel ?? 0,
    );
  }

  /// HP表示用
  int get hp {
    return ((userStatus?.healthPoint ?? 0) / 10).floor();
  }

  /// ユーザー名
  String get userName {
    return userStatus?.userName ?? "";
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