import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';
import '../../../views/app.dart';
import '../../../models/friend_info.dart';

class FriendHomeScreen extends StatelessWidget {
  final FriendInfo friendInfo;
  final Function(PageType) onTabSelected;

  const FriendHomeScreen({
    super.key,
    required this.friendInfo,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = FriendHomeViewModel(friendInfo: friendInfo);

    return FriendHomeView(viewModel: viewModel, onTabSelected: onTabSelected);
  }
}
