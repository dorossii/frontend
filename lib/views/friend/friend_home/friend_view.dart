import 'package:flutter/material.dart';
import '../rescue/friend_normal_view.dart';
import '../rescue/friend_rip_event.dart';
import 'friend_view_model.dart';
import '../../app.dart';

class FriendHomeView extends StatelessWidget {
  final FriendHomeViewModel viewModel;
  final Function(PageType) onTabSelected;

  const FriendHomeView({
    super.key,
    required this.viewModel,
    required this.onTabSelected,
  });
  @override
  Widget build(BuildContext context) {
    if (viewModel.isEvent) {
      return FriendRipEvent(viewModel: viewModel, onTabSelected: onTabSelected);
    }

    return FriendNormalHomeView(
      viewModel: viewModel,
      onTabSelected: onTabSelected,
    );
  }
}
