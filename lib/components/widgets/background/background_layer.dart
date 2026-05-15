// ==============================================
// widgets/background/background_layer.dart
// ==============================================

import 'package:flutter/material.dart';

import '../../models/state_theme.dart';

class BackgroundLayer extends StatelessWidget {

  final StateTheme theme;

  const BackgroundLayer({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned.fill(
      child: Image.asset(
        theme.background,
        fit: BoxFit.cover,
      ),
    );
  }
}