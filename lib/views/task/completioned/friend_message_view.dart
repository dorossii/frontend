import 'package:authbase_mobile/models/friend_info.dart';
import 'package:authbase_mobile/views/component/task/create_message_design.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

// フレンドにメッセージを送る画面
class FriendMessageView extends StatefulWidget {
  final TaskViewModel viewModel;
  final FriendInfo friendData;

  const FriendMessageView({
    super.key,
    required this.viewModel,
    required this.friendData,
  });

  @override
  State<FriendMessageView> createState() => _FriendMessageView();
}

class _FriendMessageView extends State<FriendMessageView> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    widget.viewModel.initialize(() {
      // API取得後UI更新
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateMessageDesign(
      viewModel: widget.viewModel,
      controller: _controller,
      labelText: "${widget.friendData.userName}向けて、メッセージを送ろう！",
      sendUserId: widget.friendData.userId,
    );
  }
}