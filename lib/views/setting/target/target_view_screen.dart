import 'package:flutter/material.dart';
import 'target_view.dart';
import 'target_view_model.dart';

class TargetListScreen extends StatefulWidget {
  const TargetListScreen({super.key});

  @override
  State<TargetListScreen> createState() => _TargetListScreenState();
}

class _TargetListScreenState extends State<TargetListScreen> {
  late final TargetListViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = TargetListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return TargetListView(viewModel: viewModel);
  }
}