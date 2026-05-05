import 'package:flutter/material.dart';
import 'task_view_model.dart';

class TaskView extends StatelessWidget {
  final TaskViewModel viewModel;

  const TaskView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Task'));
  }
}