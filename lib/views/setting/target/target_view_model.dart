import 'package:flutter/material.dart';

import '../../../components/models/status.dart';
import '../../../models/friend_info.dart';
import '../../../models/target_info.dart';
import '../../../services/friend/friend_service.dart';
import '../../../services/friend/target_service.dart';

class TargetListViewModel {
  LifeState currentState = LifeState.normal;

  final FriendService _service = FriendService();
  final TargetService _targetService = TargetService();

  /// フレンド一覧
  List<FriendInfo> friendList = [];

  /// 表示用フレンド一覧
  List<FriendInfo> filteredFriendList = [];

  /// 現在の嫌がらせ対象
  TargetInfo? targetInfo;

  /// ローディング状態
  bool isLoading = false;

  /// 初期化
  Future<void> initialize(void Function() onUpdate) async {
    await fetchData(onUpdate);
  }

  /// フレンド一覧と嫌がらせ対象を取得
  Future<void> fetchData(void Function() onUpdate) async {
    if (isLoading) return;

    isLoading = true;

    try {
      // フレンド一覧とターゲットを取得
      final results = await Future.wait([
        _service.fetchFriendInfo(),
        _targetService.fetchTargetInfo(),
      ]);

      // フレンド一覧
      final friends = results[0] as List<FriendInfo>;

      // 嫌がらせ対象（1人）
      final target = results[1] as TargetInfo;

      friendList = friends;
      filteredFriendList = List.from(friends);

      targetInfo = target;

      if (friends.isNotEmpty) {
        currentState = LifeState.fromValue(
          friends.first.dirtLevel,
        );
      }
    } catch (e) {
      debugPrint('target fetch error: $e');
    }

    isLoading = false;

    onUpdate();
  }

  /// 指定したユーザーが嫌がらせ対象か
  bool isTarget(String userId) {
    return targetInfo?.targetUser == userId;
  }

  /// フレンド検索
  void searchFriend(String keyword) {
    final text = keyword.trim();

    if (text.isEmpty) {
      filteredFriendList = List.from(friendList);
      return;
    }

    filteredFriendList = friendList.where((friend) {
      return friend.userName.toLowerCase().contains(
        text.toLowerCase(),
      );
    }).toList();
  }

  /// 嫌がらせ対象をローカル上で切り替える
  void toggleTarget(String userId) {
    if (targetInfo?.targetUser == userId) {
      // 現在のターゲットを解除
      targetInfo = TargetInfo(targetUser: '');
    } else {
      // 新しいターゲットに変更
      targetInfo = TargetInfo(targetUser: userId);
    }
  }
}