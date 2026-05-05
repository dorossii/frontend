import 'package:flutter/material.dart';
import 'setting_view.dart';
import 'setting_view_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = SettingViewModel();

    return SettingView(viewModel: viewModel);
  }
}