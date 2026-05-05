import 'package:flutter/material.dart';
import 'setting_view_model.dart';

class SettingView extends StatelessWidget {
  final SettingViewModel viewModel;

  const SettingView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Setting'));
  }
}