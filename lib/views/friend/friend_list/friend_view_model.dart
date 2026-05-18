import 'package:flutter/material.dart';
import '../friend_home/friend_screen.dart';
import '../../../views/app.dart';

import '../../../components/models/status.dart';
import '../../../models/friend_info.dart';
import '../../../services/friend/friend_service.dart';

class FriendListViewModel {
  // タブ選択コールバック
  final Function(PageType) onTabSelected;

  // 汚さレベル
  LifeState currentState = LifeState.normal;

  // コンストラクタで受け取る
  FriendListViewModel({required this.onTabSelected});

  /// API通信クラス
  final FriendService _service = FriendService();

  /// APIから取得したユーザー情報
  List<FriendInfo> friendList = [];

  /// ローディング状態
  bool isLoading = false;

  /// 初期化
  Future<void> initialize(void Function() onUpdate) async {
    await fetchFriendInfo(onUpdate);
  }

  /// APIからフレンド情報取得
  Future<void> fetchFriendInfo(void Function() onUpdate) async {
    /// ローディング開始
    isLoading = true;

    /// UI更新
    onUpdate();

    try {
      /// API通信
      friendList = await _service.fetchFriendInfo();
      print(friendList.length);

      /// 汚さレベル → 状態変換
      currentState = LifeState.fromValue(friendList.first.dirtLevel);

    } catch (e) {
      /// エラー表示
      debugPrint(e.toString());
    }

    /// ローディング終了
    isLoading = false;

    /// UI更新
    onUpdate();
  }

  void onFriendTapped(BuildContext context, FriendInfo friend) {
    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            FriendHomeScreen(friendInfo: friend, onTabSelected: onTabSelected),
      ),
    );
  }
}
