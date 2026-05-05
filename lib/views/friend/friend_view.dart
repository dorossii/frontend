import 'package:flutter/material.dart';
import 'friend_view_model.dart';

class FriendView extends StatelessWidget {
  final FriendViewModel viewModel;

  const FriendView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Friend'));
  }
}