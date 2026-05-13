import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';

class FriendHomeScreen extends StatelessWidget {
  final String name;
  const FriendHomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // 詳細用のViewModelを作って、Viewに渡す
    final viewModel = FriendHomeViewModel(friendName: name);
    return FriendHomeView(viewModel: viewModel);
  }
}