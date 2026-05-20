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

  /// 初期化
  Future<void> initialize() async {
    await fetchUser();
  }

  /// ユーザー情報取得
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
}