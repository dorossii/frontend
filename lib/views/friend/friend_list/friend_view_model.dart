import 'package:flutter/material.dart';
import '../friend_home/friend_screen.dart';
import '../../../views/app.dart';

class FriendListViewModel {
  final Function(PageType) onTabSelected;

  // コンストラクタで受け取る
  FriendListViewModel({required this.onTabSelected});

  void onFriendTapped(BuildContext context, String name, Color color) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FriendHomeScreen(
          name: name, 
          themeColor: color,
          onTabSelected: onTabSelected, 
        ),
      ),
    );
  }
}