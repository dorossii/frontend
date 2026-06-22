import 'package:flutter/material.dart';
import '../friend_home/friend_screen.dart';
import '../../../views/app.dart';

import '../../../components/models/status.dart';
import '../../../models/friend_info.dart';
import '../../../services/friend/friend_service.dart';

class FriendListViewModel {
  final Function(PageType) onTabSelected;

  LifeState currentState = LifeState.normal;

  FriendListViewModel({required this.onTabSelected});

  final FriendService _service = FriendService();

  /// 元データ
  List<FriendInfo> friendList = [];

  /// 表示用
  List<FriendInfo> filteredFriendList = [];

  bool isLoading = false;

  Future<void> initialize(void Function() onUpdate) async {
    await fetchFriendInfo(onUpdate);
  }

  Future<void> fetchFriendInfo(void Function() onUpdate) async {
    if (isLoading) return;

    isLoading = true;

    try {
      final friends = await _service.fetchFriendInfo();

      // 空返却なら上書きしない
      if (friends.isNotEmpty) {
        friendList = friends;

        filteredFriendList = List.from(friends);

        currentState = LifeState.fromValue(friends.first.dirtLevel);
      }
    } catch (e) {
      debugPrint('friend fetch error $e');
    }

    isLoading = false;

    onUpdate();
  }

  void searchFriend(String keyword) {
    final text = keyword.trim();

    if (text.isEmpty) {
      filteredFriendList = List.from(friendList);

      return;
    }

    filteredFriendList = friendList.where((friend) {
      return friend.userName.toLowerCase().contains(text.toLowerCase());
    }).toList();
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
