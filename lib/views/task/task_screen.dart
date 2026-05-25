import 'package:authbase_mobile/models/task_info.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:flutter/material.dart';
import 'task_view.dart';
import 'task_view_model.dart';

class TaskScreen extends StatelessWidget {
  final TaskInfo taskInfo;
  final Function(PageType) onTabSelected;

  const TaskScreen({
    super.key,
    required this.taskInfo,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel(taskInfo: taskInfo);

    return TaskView(viewModel: viewModel, onTabSelected: onTabSelected);
  }
}