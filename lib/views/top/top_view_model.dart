import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/models/status.dart';
import '../../models/user_status.dart';
import '../../services/user/user_service.dart';

class TopViewModel {
  /// ===================================
  /// デバッグモード
  /// true  → デザイン確認用
  /// false → API使用
  /// ===================================
  final bool isDebugMode;

  TopViewModel({this.isDebugMode = false});

  LifeState currentState = LifeState.normal;

  /// デバッグ用Index
  int currentIndex = 0;

  /// タイマー
  Timer? timer;

  /// 状態一覧
  List<LifeState> states = LifeState.values;

  /// APIから取得したユーザー情報
  UserStatus? userStatus;

  /// ローディング状態
  bool isLoading = false;

  /// API通信クラス
  final UserService _service = UserService();

  /// 初期化
  Future<void> initialize(void Function() onUpdate) async {

     timer?.cancel();
    /// デバッグモード
    if (isDebugMode) {
      startDebugLoop(onUpdate);
    } else {
      await fetchUser(onUpdate);
    }
  }

  /// APIからユーザー情報取得
  Future<void> fetchUser(void Function() onUpdate) async {
    /// ローディング開始
    isLoading = true;

    /// UI更新
    onUpdate();

    try {
      /// API通信
      userStatus = await _service.fetchUserStatus();

      /// 汚さレベル → 状態変換
      currentState = LifeState.fromValue(userStatus!.dirtLevel);
    } catch (e) {
      /// エラー表示
      debugPrint(e.toString());
    }

    /// ローディング終了
    isLoading = false;

    /// UI更新
    onUpdate();
  }

  /// デバッグ用状態切り替え
  void startDebugLoop(void Function() onUpdate) {
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      /// 次の状態へ
      currentIndex++;

      /// 最後まで行ったら戻る
      if (currentIndex >= states.length) {
        currentIndex = 0;
      }

      /// 状態更新
      currentState = states[currentIndex];

      /// UI更新
      onUpdate();
    });
  }

  /// 終了処理
  void dispose() {
    /// タイマー破棄
    timer?.cancel();
  }
}
