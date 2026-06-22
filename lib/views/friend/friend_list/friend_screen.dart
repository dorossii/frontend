import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';
import '../../../views/app.dart';

class FriendListScreen
    extends StatefulWidget {

  final Function(PageType)
      onTabSelected;

  const FriendListScreen({
    super.key,
    required this.onTabSelected,
  });

  @override
  State<FriendListScreen>
      createState() =>
          _FriendListScreenState();
}

class _FriendListScreenState
    extends State<
        FriendListScreen> {

  late final FriendListViewModel
      viewModel;

  @override
  void initState() {
    super.initState();

    viewModel =
        FriendListViewModel(
      onTabSelected:
          widget.onTabSelected,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FriendListView(
      viewModel: viewModel,
    );
  }
}