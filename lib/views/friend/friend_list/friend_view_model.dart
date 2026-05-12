import 'package:flutter/material.dart';
import '../friend_home/friend_screen.dart';

class FriendListViewModel {
  void onFriendTapped(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // 遷移先は「Screen」にする。引数は name
        builder: (context) => FriendHomeScreen(name: name),
      ),
    );
  }
}