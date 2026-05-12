import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';

class FriendHomeScreen extends StatelessWidget {
  final String name;
  const FriendHomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // 詳細画面用のViewModelを作成
    final viewModel = FriendHomeViewModel(friendName: name);
    // 詳細画面のViewに渡す
    return FriendHomeView(viewModel: viewModel);
  }
}