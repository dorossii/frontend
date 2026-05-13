import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';
import '../../../views/app.dart';

class FriendListScreen extends StatelessWidget {
  final Function(PageType) onTabSelected; 

  const FriendListScreen({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = FriendListViewModel(onTabSelected: onTabSelected);

    return FriendListView(viewModel: viewModel);
  }
}