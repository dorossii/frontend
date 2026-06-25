import 'package:authbase_mobile/components/Colors.dart';
import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/component/task/take_picture_design.dart';
import 'package:authbase_mobile/views/task/task_view_model.dart';
import 'package:flutter/material.dart';

class TakePictureView extends StatefulWidget {
  final TaskViewModel viewModel;
  final List<String> selectedTaskId;
  
  const TakePictureView({
    super.key,
    required this.viewModel,
    required this.selectedTaskId,
  });

  @override
  State<TakePictureView> createState() => _TakePictureView();
}

class _TakePictureView extends State<TakePictureView> {
  late TaskInfo lavelTask;

  @override
  void initState() {
    super.initState();

    // タスクの名前を取得
    // Todo：送られてきた選択済みの配列の一番最初の要素を取ってるので、選ばれたIDを選択するようにする処理に変更が必要
    lavelTask = widget.viewModel.taskList.firstWhere(
      (t) => t.taskId == widget.selectedTaskId[0],
    );

    widget.viewModel.initialize(() {
      // API取得後UI更新
      setState(() {});
    });
  }

  // 完了したタスクの写真を撮る画面
  @override
  Widget build(BuildContext context) {
    return TakePictureDesign(
      viewModel: widget.viewModel,
      taskName: lavelTask.taskName,
      lavelText: "完了した場所の写真を撮ろう！！",
      buttomBtn: _buttomBtn,
      pageType: "user",
      imagePath: "",
    );
  }

    Widget _buttomBtn() {

    return Container(
      height: 64,
      width: 64,
      margin: EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
        border: Border.all(color: AppColors.subBackground, width: 6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );

  }
}