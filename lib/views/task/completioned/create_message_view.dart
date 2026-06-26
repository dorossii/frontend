import 'package:authbase_mobile/models/user_status.dart';
import 'package:authbase_mobile/views/component/task/create_message_design.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

// 未来の自分にメッセージを送る画面
class CreateMessageView extends StatefulWidget {
  final TaskViewModel viewModel;
  final UserStatus userStatus;

  const CreateMessageView({
    super.key,
    required this.viewModel,
    required this.userStatus,
  });

  @override
  State<CreateMessageView> createState() => _CreateMessageView();
}

class _CreateMessageView extends State<CreateMessageView> {
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

  // 完了したタスクの写真を撮る画面
  @override
  Widget build(BuildContext context) {
    return CreateMessageDesign(
      viewModel: widget.viewModel,
      controller: _controller,
      labelText: "未来の自分に向けて、メッセージを送ろう！",
      sendUserId: widget.userStatus.userId,
    );
  }
}
