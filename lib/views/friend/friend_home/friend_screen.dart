import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';
import '../../../views/app.dart';

class FriendHomeScreen extends StatelessWidget {
  final String name; 
  final Function(PageType) onTabSelected; 

  const FriendHomeScreen({
    super.key, 
    required this.name, 
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = FriendHomeViewModel(friendName: name);
    return FriendHomeView(
      viewModel: viewModel,
      onTabSelected: onTabSelected, // Viewへ渡す
    );
  }
}