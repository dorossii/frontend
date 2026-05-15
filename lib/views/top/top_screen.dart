import 'package:flutter/material.dart';
import 'top_view.dart';
import 'top_view_model.dart';

class TopScreen extends StatefulWidget {

  const TopScreen({super.key});

  @override
  State<TopScreen> createState() =>
      _TopScreenState();
}

class _TopScreenState
    extends State<TopScreen> {

  late TopViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = TopViewModel();

    /// デバッグ開始
    viewModel.startDebugLoop(() {

      setState(() {});
    });
  }

  @override
  void dispose() {

    viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return TopView(
      viewModel: viewModel,
    );
  }
}