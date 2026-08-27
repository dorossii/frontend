import 'package:flutter/material.dart';

import '../../../models/friend_rescue.dart';
import '../../../services/friend/friend_rescue_service.dart';

// レスキューのビューモデル
class RescueViewModel extends ChangeNotifier {
  final FriendRescueService _service = FriendRescueService();

  List<RescueFriend> rescueFriends = [];
  bool isLoading = false;

  /// フレンド一覧（レスキュー状態を含む）を取得
  Future<List<RescueFriend>> getFriends() async {
    isLoading = true;
    notifyListeners();

    try {
      rescueFriends = await _service.fetchFriendInfo();
    } catch (e) {
      debugPrint('レスキューデータ取得エラー: $e');
      rescueFriends = [];
    }

    isLoading = false;
    notifyListeners();

    return rescueFriends;
  }
}