import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';

class FriendListScreen extends StatelessWidget {
  const FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = FriendListViewModel();

    return FriendListView(viewModel: viewModel);
  }
}