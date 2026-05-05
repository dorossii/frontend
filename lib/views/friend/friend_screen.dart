import 'package:flutter/material.dart';
import 'friend_view.dart';
import 'friend_view_model.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = FriendViewModel();

    return FriendView(viewModel: viewModel);
  }
}