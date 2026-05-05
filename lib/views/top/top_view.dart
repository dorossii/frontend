import 'package:flutter/material.dart';
import 'top_view_model.dart';

class TopView extends StatelessWidget {
  final TopViewModel viewModel;

  const TopView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Top'));
  }
}