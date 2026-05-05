import 'package:flutter/material.dart';
import 'top_view.dart';
import 'top_view_model.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = TopViewModel();

    return TopView(viewModel: viewModel);
  }
}