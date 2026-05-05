import 'package:flutter/material.dart';
import 'task_view.dart';
import 'task_view_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = TaskViewModel();

    return TaskView(viewModel: viewModel);
  }
}