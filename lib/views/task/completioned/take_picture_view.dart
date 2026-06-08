import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';


class TakePictureView extends StatefulWidget {
  final TaskViewModel viewModel;
  
  const TakePictureView({
    super.key,
    required this.viewModel,
  });

  @override
  State<TakePictureView> createState() => _TakePictureView();
}

class _TakePictureView extends State<TakePictureView> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.initialize(() {
      // API取得後UI更新
      setState(() {});
    });
  }
  
  // 完了したタスクの写真を撮る画面
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}